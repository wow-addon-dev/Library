local _, LIB = ...

---@class ArcaneWizardLibraryAddon
---@field name string
---@field version string|nil
---@field buildDate string|nil
---@field mediaPath string
---@field mainCategoryId number|nil
---@field debugEnabled boolean|fun(): boolean

---@class ArcaneWizardLibraryAddonConfig
---@field debugEnabled boolean|fun(): boolean|nil

local AddonContextMixin = {}

local AddonChat = LIB.Internal.AddonChat
local AddonLauncher = LIB.Internal.AddonLauncher

local addonContexts = {}

-----------------------
--- Local Functions ---
-----------------------

local function ResolveDebugEnabled(debugEnabled)
	if type(debugEnabled) == "function" then
		return debugEnabled() == true
	end

	return debugEnabled == true
end

---@param addonName string
---@param config ArcaneWizardLibraryAddonConfig|nil
---@return ArcaneWizardLibraryAddon context
local function CreateAddonContext(addonName, config)
	if addonContexts[addonName] then
		return addonContexts[addonName]
	end

	local context = {
		name = addonName,
		version = C_AddOns.GetAddOnMetadata(addonName, "Version"),
		buildDate = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate"),
		mediaPath = "Interface\\AddOns\\" .. addonName .. "\\assets\\",
		debugEnabled = config and config.debugEnabled or false
	}

	setmetatable(context, { __index = AddonContextMixin })
	addonContexts[addonName] = context

	return context
end

local function GetAddonContext(addonName)
	return addonContexts[addonName]
end

--------------------------
--- Addon Context API ---
--------------------------

--- Returns the addon media path or a media file path below it.
---
--- @param fileName string|nil Optional media file name below the addon media path.
---
--- @return string mediaPath The addon media path.
function AddonContextMixin:GetMediaPath(fileName)
	if fileName and fileName ~= "" then
		return self.mediaPath .. fileName
	end

	return self.mediaPath
end

--- Stores the Blizzard settings category ID for this addon.
---
--- @param categoryId number
function AddonContextMixin:SetMainCategoryId(categoryId)
	self.mainCategoryId = categoryId
end

--- Opens the stored Blizzard settings category when not blocked by combat lockdown.
---
--- @return boolean opened True when the settings category was opened.
function AddonContextMixin:OpenCategory()
	local categoryId = self.mainCategoryId

	if not categoryId then
		return false
	end

	if not InCombatLockdown() then
		Settings.OpenToCategory(categoryId)
		return true
	end

	self:PrintDebug("In combat. The options menu cannot be opened.")
	return false
end

--- Prints a normal addon chat message.
---
--- @param msg string Message to print.
function AddonContextMixin:PrintMessage(msg)
	AddonChat:PrintMessage(self, msg)
end

--- Prints an addon debug message when debug output is enabled.
---
--- @param msg string Debug message to print.
function AddonContextMixin:PrintDebug(msg)
	AddonChat:PrintDebug(self, msg, ResolveDebugEnabled(self.debugEnabled))
end

--- Registers a LibDataBroker minimap button for this addon.
---
--- @param config table Minimap button configuration.
---
--- @return table minimapButton The LibDBIcon instance.
function AddonContextMixin:RegisterMinimapButton(config)
	return AddonLauncher:RegisterMinimapButton(self, config)
end

--- Creates AddonCompartment handler functions for this addon.
---
--- @param config table Compartment configuration.
---
--- @return table handlers Handler table with OnEnter, OnLeave, and OnClick functions.
function AddonContextMixin:CreateCompartmentHandlers(config)
	return AddonLauncher:CreateCompartmentHandlers(self, config)
end

------------------------
--- Public Functions ---
------------------------

--- Creates an addon context.
---
--- @param addonName string The addon name.
--- @param config ArcaneWizardLibraryAddonConfig|nil Optional context configuration.
---
--- @return ArcaneWizardLibraryAddon context The addon context.
function ArcaneWizardLibrary:NewAddon(addonName, config)
	return CreateAddonContext(addonName, config)
end

--- Returns a registered addon context.
---
--- @param addonName string The addon name.
---
--- @return ArcaneWizardLibraryAddon|nil context The registered addon context.
function ArcaneWizardLibrary:GetAddon(addonName)
	return GetAddonContext(addonName)
end
