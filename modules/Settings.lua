local _, LIB = ...

local L = LIB.Localization

local function GetInfoTextHeight(config)
    if type(config.height) == "number" then
        return config.height
    end

    if type(config.height) == "string" and LIB.INFO_TEXT_HEIGHTS[config.height] then
        return LIB.INFO_TEXT_HEIGHTS[config.height]
    end

    return LIB.INFO_TEXT_HEIGHTS["default"]
end

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

    if config.parentInit and config.parentCondition then
        initializer:SetParentInitializer(config.parentInit, config.parentCondition)
    end

    if config.shownPredicate then
        initializer:AddShownPredicate(config.shownPredicate)
    end

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

    if config.parentInit and config.parentCondition then
        initializer:SetParentInitializer(config.parentInit, config.parentCondition)
    end

    if config.shownPredicate then
        initializer:AddShownPredicate(config.shownPredicate)
    end

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

    if config.parentInit and config.parentCondition then
        initializer:SetParentInitializer(config.parentInit, config.parentCondition)
    end

    if config.shownPredicate then
        initializer:AddShownPredicate(config.shownPredicate)
    end

    if config.onClick then
        setting:SetValueChangedCallback(config.onClick)
    end

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

    if config.parentInit and config.parentCondition then
        initializer:SetParentInitializer(config.parentInit, config.parentCondition)
    end

    if config.shownPredicate then
        initializer:AddShownPredicate(config.shownPredicate)
    end

    if config.onClick then
        setting:SetValueChangedCallback(config.onClick)
    end

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
    local checkboxVariableName = config.checkboxVariableName or config.checkboxVarName
    local settingCheckbox = Settings.RegisterAddOnSetting(category, config.checkboxSettingKey, checkboxVariableName, config.variableTable, Settings.VarType.Boolean, config.checkboxName, config.checkboxDefault or false)
    local settingSlider = Settings.RegisterAddOnSetting(category, config.sliderSettingKey, config.sliderVariableName, config.variableTable, Settings.VarType.Number, config.sliderName, config.sliderDefault or 1)
    local optionsSlider = Settings.CreateSliderOptions(config.sliderMin or 1, config.sliderMax or 10, config.sliderStep or 1)

    if config.sliderFormatter then
        optionsSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, config.sliderFormatter)
    end

    local initializer = CreateSettingsCheckboxSliderInitializer(settingCheckbox, config.checkboxName, config.checkboxTooltip, settingSlider, optionsSlider, config.sliderName, config.sliderTooltip)
    initializer.GetSetting = function() return settingCheckbox end

    if config.parentInit and config.parentCondition then
        initializer:SetParentInitializer(config.parentInit, config.parentCondition)
    end

    if config.shownPredicate then
        initializer:AddShownPredicate(config.shownPredicate)
    end

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

    if config.parentInit and config.parentCondition then
        initializer:SetParentInitializer(config.parentInit, config.parentCondition)
    end

    if config.shownPredicate then
        initializer:AddShownPredicate(config.shownPredicate)
    end

    if config.onClick then
        setting:SetValueChangedCallback(config.onClick)
    end

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

    initializer:Init("ArcaneWizardLibrary_SettingsExpandTemplate", data)
    initializer.GetExtent = ScrollBoxFactoryInitializerMixin.GetExtent

    layout:AddInitializer(initializer)

    return initializer, function() return initializer.data.expanded end
end
