# Settings Page Example

This example creates a Blizzard settings page with a checkbox, slider, dropdown, and about section.

```lua
local addonName = ...

MyAddonDB = MyAddonDB or {
  debug = false,
  scale = 1,
  mode = "compact"
}

local addon = ArcaneWizardLibrary:NewAddon(addonName, {
  debugEnabled = function()
    return MyAddonDB.debug
  end
})

local category, layout = Settings.RegisterVerticalLayoutCategory("My Addon")
Settings.RegisterAddOnCategory(category)
addon:SetMainCategoryId(category:GetID())

ArcaneWizardLibrary.Settings:AddCheckbox(category, {
  settingKey = "my-addon-debug",
  variableName = "debug",
  variableTable = MyAddonDB,
  name = "Debug output",
  tooltip = "Print additional diagnostic messages.",
  default = false
})

ArcaneWizardLibrary.Settings:AddSlider(category, {
  settingKey = "my-addon-scale",
  variableName = "scale",
  variableTable = MyAddonDB,
  name = "Window scale",
  tooltip = "Controls the main window scale.",
  default = 1,
  minValue = 0.8,
  maxValue = 1.4,
  step = 0.1,
  formatter = function(value)
    return string.format("%d%%", value * 100)
  end
})

ArcaneWizardLibrary.Settings:AddDropdown(category, {
  settingKey = "my-addon-mode",
  variableName = "mode",
  variableTable = MyAddonDB,
  name = "Mode",
  tooltip = "Select the behavior mode.",
  default = "compact",
  options = {
    { value = "compact", label = "Compact" },
    { value = "detailed", label = "Detailed" }
  }
})

ArcaneWizardLibrary.Settings:AddAboutSection(layout, addonName)
```
