local _, LIB = ...

local L = LIB.Localization

-----------------------
--- Local Functions ---
-----------------------

local function GetInfoTextHeight(config)
	if type(config.height) == "number" then
		return config.height
	end

	if type(config.height) == "string" and LIB.INFO_TEXT_HEIGHTS[config.height] then
		return LIB.INFO_TEXT_HEIGHTS[config.height]
	end

	return LIB.INFO_TEXT_HEIGHTS["default"]
end

local function FormatAboutValue(value, detail)
	if not value then
		return ""
	end

	if detail and detail ~= "" then
		return tostring(value) .. " (" .. tostring(detail) .. ")"
	end

	return tostring(value)
end

local function GetAddonMetadata(addonName, key)
	if not addonName then
		return nil
	end

	return C_AddOns.GetAddOnMetadata(addonName, key)
end

local function ApplyInitializerConfig(initializer, config)
	if config.parentInit and config.parentCondition then
		initializer:SetParentInitializer(config.parentInit, config.parentCondition)
	end

	if config.shownPredicate then
		initializer:AddShownPredicate(config.shownPredicate)
	end
end

local function ApplySettingConfig(setting, config)
	if config.onClick then
		setting:SetValueChangedCallback(config.onClick)
	end
end

local function NormalizeAboutConfig(config)
	if type(config) == "string" then
		config = {
			addonName = config
		}
	else
		config = config or {}
	end

	local addonName = config.addonName

	if addonName then
		config.addonVersion = config.addonVersion or GetAddonMetadata(addonName, "Version")
		config.addonBuildDate = config.addonBuildDate or GetAddonMetadata(addonName, "X-BuildDate")
		config.addonAuthor = config.addonAuthor or GetAddonMetadata(addonName, "Author")
		config.curseforgeLink = config.curseforgeLink or GetAddonMetadata(addonName, "X-Curseforge")
		config.wagoLink = config.wagoLink or GetAddonMetadata(addonName, "X-Wago")
		config.githubLink = config.githubLink or GetAddonMetadata(addonName, "X-Github")
	end

	return config
end

------------------------
--- Public Functions ---
------------------------

--- Adds a clickable button to the settings layout.
---
--- @param layout table The layout object to append the initializer to.
--- @param config table Configuration table. Expected keys: name, buttonText, onClick, tooltip. Optional keys: parentInit, parentCondition, shownPredicate.
---
--- @return table initializer The layout initializer object for the button.
function ArcaneWizardLibrary.Settings:AddButton(layout, config)
	local initializer = CreateSettingsButtonInitializer(
		config.name,
		config.buttonText,
		config.onClick,
		config.tooltip,
		true
	)

	ApplyInitializerConfig(initializer, config)

	layout:AddInitializer(initializer)

	return initializer
end

--- Adds a static text row to the settings layout, typically used for key-value pairs (e.g., in an "About" section).
---
--- @param layout table The layout object to append the initializer to.
--- @param config table Configuration table. Expected keys: leftText, rightText. Optional keys: height number|string ("compact" or "default"), parentInit, parentCondition, shownPredicate.
---
--- @return table initializer The layout initializer object for the text panel.
function ArcaneWizardLibrary.Settings:AddInfoText(layout, config)
	local initializer = Settings.CreateElementInitializer("ArcaneWizardLibrary_SettingsPanelText", {
		leftText = config.leftText or "",
		rightText = config.rightText or "",
	})

	ApplyInitializerConfig(initializer, config)

	local line = layout:AddInitializer(initializer)

	function line:GetExtent()
		return GetInfoTextHeight(config)
	end

	return initializer
end

--- Registers and adds a standard checkbox to the settings layout.
---
--- @param category table The settings category object.
--- @param config table Configuration table. Expected keys: settingKey, variableName, variableTable, name, tooltip, default. Optional keys: parentInit, parentCondition, shownPredicate, onClick.
---
--- @return table initializer The layout initializer object for the checkbox.
--- @return table setting The registered setting object.
function ArcaneWizardLibrary.Settings:AddCheckbox(category, config)
	local setting = Settings.RegisterAddOnSetting(category, config.settingKey, config.variableName, config.variableTable, Settings.VarType.Boolean, config.name, config.default or false)
	local initializer = Settings.CreateCheckbox(category, setting, config.tooltip)

	ApplyInitializerConfig(initializer, config)
	ApplySettingConfig(setting, config)

	return initializer, setting
end

--- Registers and adds a Slider element to the settings layout.
---
--- @param category table The settings category object.
--- @param config table Configuration table. Expected keys: settingKey, variableName, variableTable, name, tooltip, default, minValue, maxValue, step, formatter. Optional keys: parentInit, parentCondition, shownPredicate, onClick.
---
--- @return table initializer The layout initializer object for the slider.
--- @return table setting The registered setting object.
function ArcaneWizardLibrary.Settings:AddSlider(category, config)
	local setting = Settings.RegisterAddOnSetting(category, config.settingKey, config.variableName, config.variableTable, Settings.VarType.Number, config.name, config.default or 1)
	local options = Settings.CreateSliderOptions(config.minValue or 1, config.maxValue or 10, config.step or 1)

	if config.formatter then
		options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, config.formatter)
	end

	local initializer = Settings.CreateSlider(category, setting, options, config.tooltip)

	ApplyInitializerConfig(initializer, config)
	ApplySettingConfig(setting, config)

	return initializer, setting
end

--- Registers and adds a combined Checkbox and Slider element to the settings layout.
---
--- @param category table The settings category object.
--- @param layout table The layout object to append the initializer to.
--- @param config table Configuration table. Expected keys: checkboxSettingKey, checkboxVariableName, checkboxName, checkboxTooltip, checkboxDefault, sliderSettingKey, sliderVariableName, sliderName, sliderTooltip, sliderDefault, sliderMin, sliderMax, sliderStep, sliderFormatter, variableTable. Optional keys: parentInit, parentCondition, shownPredicate.
---
--- @return table initializer The layout initializer object for the combined element.
--- @return table settingCheckbox The registered setting object for the checkbox.
--- @return table settingSlider The registered setting object for the slider.
function ArcaneWizardLibrary.Settings:AddCheckboxSliderCombo(category, layout, config)
	local settingCheckbox = Settings.RegisterAddOnSetting(category, config.checkboxSettingKey, config.checkboxVariableName, config.variableTable, Settings.VarType.Boolean, config.checkboxName, config.checkboxDefault or false)
	local settingSlider = Settings.RegisterAddOnSetting(category, config.sliderSettingKey, config.sliderVariableName, config.variableTable, Settings.VarType.Number, config.sliderName, config.sliderDefault or 1)
	local optionsSlider = Settings.CreateSliderOptions(config.sliderMin or 1, config.sliderMax or 10, config.sliderStep or 1)

	if config.sliderFormatter then
		optionsSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, config.sliderFormatter)
	end

	local initializer = CreateSettingsCheckboxSliderInitializer(settingCheckbox, config.checkboxName, config.checkboxTooltip, settingSlider, optionsSlider, config.sliderName, config.sliderTooltip)
	initializer.GetSetting = function() return settingCheckbox end

	ApplyInitializerConfig(initializer, config)

	layout:AddInitializer(initializer)

	return initializer, settingCheckbox, settingSlider
end

--- Registers and adds a Dropdown menu to the settings layout.
---
--- @param category table The settings category object.
--- @param config table Configuration table. Expected keys: settingKey, variableName, variableTable, name, tooltip, default, options. Optional keys: parentInit, parentCondition, shownPredicate, onClick.
---
--- @return table initializer The layout initializer object for the dropdown.
--- @return table setting The registered setting object.
function ArcaneWizardLibrary.Settings:AddDropdown(category, config)
	local varType = type(config.default) == "string" and Settings.VarType.String or Settings.VarType.Number
	local setting = Settings.RegisterAddOnSetting(category, config.settingKey, config.variableName, config.variableTable, varType, config.name, config.default)

	local function GetOptions()
		local container = Settings.CreateControlTextContainer()
		if config.options then
			for _, opt in ipairs(config.options) do
				container:Add(opt.value, opt.label)
			end
		end
		return container:GetData()
	end

	local initializer = Settings.CreateDropdown(category, setting, GetOptions, config.tooltip)

	ApplyInitializerConfig(initializer, config)
	ApplySettingConfig(setting, config)

	return initializer, setting
end

--- Adds an expandable header section to the settings layout.
---
--- @param layout table The layout object to append the initializer to.
--- @param name string The display name of the header.
---
--- @return table initializer The layout initializer object for the header.
--- @return function isExpandedPredicate A function that returns the current expanded state (boolean).
function ArcaneWizardLibrary.Settings:AddExpandableHeader(layout, name)
	local initializer = CreateFromMixins(SettingsExpandableSectionInitializer)
	local data = { name = name, expanded = false }

	initializer:Init("ArcaneWizardLibrary_SettingsExpandTemplate")
	initializer.data = data
	initializer.GetExtent = ScrollBoxFactoryInitializerMixin.GetExtent

	layout:AddInitializer(initializer)

	return initializer, function() return data.expanded end
end

--- Adds a standard Profiles section to the settings layout.
---
--- @param layout table The layout object to append the initializers to.
--- @param config table Configuration table. Expected keys: useAccountProfile, onSwitchProfile, onDeleteCharacterProfiles.
function ArcaneWizardLibrary.Settings:AddProfilesSection(layout, config)
	local profileModeText = L["settings.profiles.mode.character"]
	local switchButtonText = L["settings.profiles.switch.button.character-to-account"]

	if config.useAccountProfile then
		profileModeText = L["settings.profiles.mode.account"]
		switchButtonText = L["settings.profiles.switch.button.account-to-character"]
	end

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["settings.profiles.section-header"]))

	self:AddInfoText(layout, {
		leftText  = L["settings.profiles.profile-mode"],
		rightText = profileModeText
	})

	self:AddButton(layout, {
		name       = L["settings.profiles.switch.name"],
		buttonText = switchButtonText,
		tooltip    = L["settings.profiles.switch.tooltip"],
		onClick    = function()
			local confirmText = L["settings.profiles.switch.confirm.character-to-account"]

			if config.useAccountProfile then
				confirmText = L["settings.profiles.switch.confirm.account-to-character"]
			end

			ArcaneWizardLibrary.Dialogs:ShowConfirmDialog(confirmText, config.onSwitchProfile)
		end
	})

	self:AddButton(layout, {
		name       = L["settings.profiles.delete-character-profiles.name"],
		buttonText = L["settings.profiles.delete-character-profiles.button"],
		tooltip    = L["settings.profiles.delete-character-profiles.tooltip"],
		onClick    = function()
			ArcaneWizardLibrary.Dialogs:ShowConfirmDialog(
				L["settings.profiles.delete-character-profiles.confirm"],
				config.onDeleteCharacterProfiles
			)
		end
	})
end

--- Adds a standard About section to the settings layout.
---
--- @param layout table The layout object to append the initializers to.
--- @param addonNameOrConfig string|table Addon name or configuration table. Optional table keys: addonName, addonVersion, addonBuildDate, addonAuthor, curseforgeLink, wagoLink, githubLink.
function ArcaneWizardLibrary.Settings:AddAboutSection(layout, addonNameOrConfig)
	local config = NormalizeAboutConfig(addonNameOrConfig)

	layout:AddInitializer(CreateSettingsListSectionHeaderInitializer(L["settings.about"]))

	self:AddInfoText(layout, {
		leftText  = L["settings.about.game-version"],
		rightText = FormatAboutValue(ArcaneWizardLibrary.GAME_VERSION, ArcaneWizardLibrary.GAME_FLAVOR),
		height    = "compact"
	})

	self:AddInfoText(layout, {
		leftText  = L["settings.about.addon-version"],
		rightText = FormatAboutValue(config.addonVersion, config.addonBuildDate),
		height    = "compact"
	})

	self:AddInfoText(layout, {
		leftText  = L["settings.about.lib-version"],
		rightText = FormatAboutValue(ArcaneWizardLibrary.ADDON_VERSION, ArcaneWizardLibrary.ADDON_BUILD_DATE),
		height    = "compact"
	})

	self:AddInfoText(layout, {
		leftText  = L["settings.about.author"],
		rightText = config.addonAuthor or ""
	})

	if config.curseforgeLink and config.curseforgeLink ~= "" then
		self:AddButton(layout, {
			name       = L["settings.about.button-curseforge.name"],
			buttonText = L["settings.about.button-curseforge.button"],
			tooltip    = L["settings.about.button-curseforge.tooltip"],
			onClick    = function()
				ArcaneWizardLibrary.Dialogs:ShowLinkDialog(config.curseforgeLink)
			end
		})
	end

	if config.wagoLink and config.wagoLink ~= "" then
		self:AddButton(layout, {
			name       = L["settings.about.button-wago.name"],
			buttonText = L["settings.about.button-wago.button"],
			tooltip    = L["settings.about.button-wago.tooltip"],
			onClick    = function()
				ArcaneWizardLibrary.Dialogs:ShowLinkDialog(config.wagoLink)
			end
		})
	end

	if config.githubLink and config.githubLink ~= "" then
		self:AddButton(layout, {
			name       = L["settings.about.button-github.name"],
			buttonText = L["settings.about.button-github.button"],
			tooltip    = L["settings.about.button-github.tooltip"],
			onClick    = function()
				ArcaneWizardLibrary.Dialogs:ShowLinkDialog(config.githubLink)
			end
		})
	end
end
