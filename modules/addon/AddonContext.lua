local _, LIB = ...

---@class ArcaneWizardLibraryAddon
---@field name string
---@field version string|nil
---@field buildDate string|nil
---@field mediaPath string
---@field mainCategoryId number|nil
---@field changelog ArcaneWizardLibraryChangelogVersion[]|nil
---@field GetMediaPath fun(self: ArcaneWizardLibraryAddon, fileName: string|nil): string Returns the addon media path or a media file path below it.
---@field SetMainCategoryId fun(self: ArcaneWizardLibraryAddon, categoryId: number) Stores the Blizzard settings category ID for this addon.
---@field OpenCategory fun(self: ArcaneWizardLibraryAddon): boolean Opens the stored Blizzard settings category when not blocked by combat lockdown.
---@field SetChangelog fun(self: ArcaneWizardLibraryAddon, versions: ArcaneWizardLibraryChangelogVersion[]) Stores structured changelog versions for this addon.
---@field OpenChangelog fun(self: ArcaneWizardLibraryAddon): ArcaneWizardLibraryWindowFrame Opens the addon's changelog window.
---@field AddChangelogButton fun(self: ArcaneWizardLibraryAddon, layout: table): table Adds a localized changelog button to a Blizzard settings layout.
---@field RegisterMinimapButton fun(self: ArcaneWizardLibraryAddon, config: table): table Registers a LibDataBroker minimap button for this addon.
---@field CreateCompartmentHandlers fun(self: ArcaneWizardLibraryAddon, config: table): table Creates AddonCompartment handler functions for this addon.

local AddonContextMixin = {}

local AddonChangelog = LIB.Internal.AddonChangelog
local AddonLauncher = LIB.Internal.AddonLauncher

local addonContexts = {}

---@param addonName string
---@return ArcaneWizardLibraryAddon context
local function CreateAddonContext(addonName)
	if addonContexts[addonName] then
		return addonContexts[addonName]
	end

	local context = {
		name = addonName,
		version = C_AddOns.GetAddOnMetadata(addonName, "Version"),
		buildDate = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate"),
		mediaPath = "Interface\\AddOns\\" .. addonName .. "\\assets\\"
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

	assert(categoryId, "Arcane Wizard: Library (Debug): No Options Category ID defined for " .. tostring(self.name) .. ". The options menu cannot be opened.")

	if not InCombatLockdown() then
		Settings.OpenToCategory(categoryId)
		return true
	end

	return false
end

function AddonContextMixin:SetChangelog(versions)
	AddonChangelog:Set(self, versions)
end

function AddonContextMixin:OpenChangelog()
	return AddonChangelog:Open(self)
end

function AddonContextMixin:AddChangelogButton(layout)
	return AddonChangelog:AddSettingsButton(self, layout)
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
---
--- @return ArcaneWizardLibraryAddon context The addon context.
function ArcaneWizardLibrary:NewAddon(addonName)
	assert(type(addonName) == "string" and addonName ~= "", "Arcane Wizard: Library (Debug): No addon name defined.")

	return CreateAddonContext(addonName)
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
