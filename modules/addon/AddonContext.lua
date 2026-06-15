local _, LIB = ...

---@class ArcaneWizardLibraryAddonConfig
---@field debugEnabled boolean|fun(): boolean|nil

---@class ArcaneWizardLibraryAddon
---@field name string
---@field version string|nil
---@field buildDate string|nil
---@field mediaPath string
---@field mainCategoryId number|nil
---@field debugEnabled boolean|fun(): boolean
---@field GetMediaPath fun(self: ArcaneWizardLibraryAddon, fileName: string|nil): string Returns the addon media path or a media file path below it.
---@field SetMainCategoryId fun(self: ArcaneWizardLibraryAddon, categoryId: number) Stores the Blizzard settings category ID for this addon.
---@field OpenCategory fun(self: ArcaneWizardLibraryAddon): boolean Opens the stored Blizzard settings category when not blocked by combat lockdown.
---@field PrintMessage fun(self: ArcaneWizardLibraryAddon, msg: string) Prints a normal addon chat message.
---@field PrintDebug fun(self: ArcaneWizardLibraryAddon, msg: string) Prints an addon debug message when debug output is enabled.
---@field RegisterMinimapButton fun(self: ArcaneWizardLibraryAddon, config: table): table Registers a LibDataBroker minimap button for this addon.
---@field CreateCompartmentHandlers fun(self: ArcaneWizardLibraryAddon, config: table): table Creates AddonCompartment handler functions for this addon.

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

--------------------------
--- Addon Context API ---
--------------------------

function AddonContextMixin:GetMediaPath(fileName)
	if fileName and fileName ~= "" then
		return self.mediaPath .. fileName
	end

	return self.mediaPath
end

function AddonContextMixin:SetMainCategoryId(categoryId)
	self.mainCategoryId = categoryId
end

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

function AddonContextMixin:PrintMessage(msg)
	AddonChat:PrintMessage(self, msg)
end

function AddonContextMixin:PrintDebug(msg)
	AddonChat:PrintDebug(self, msg, ResolveDebugEnabled(self.debugEnabled))
end

function AddonContextMixin:RegisterMinimapButton(config)
	return AddonLauncher:RegisterMinimapButton(self, config)
end

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
--- @return ArcaneWizardLibraryAddon context The registered addon context.
function ArcaneWizardLibrary:GetAddon(addonName)
	local context = addonContexts[addonName]

	assert(context, "Arcane Wizard: Library (Debug): addon context is not initialized for " .. tostring(addonName))

	return context
end
