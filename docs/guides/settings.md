# Settings

`ArcaneWizardLibrary.Settings` contains wrappers around Blizzard's settings API. Use them when your addon needs common settings rows without repeating the same registration and initializer code.

## Basic category

```lua
local addon = ArcaneWizardLibrary:NewAddon("MyAddon")

local category, layout = Settings.RegisterVerticalLayoutCategory("My Addon")
Settings.RegisterAddOnCategory(category)
addon:SetMainCategoryId(category:GetID())
```

Use the returned `category` for registered controls and the `layout` for custom rows. Store the category ID on your addon context so launcher buttons can open the settings page later.

## Checkbox

```lua
ArcaneWizardLibrary.Settings:AddCheckbox(category, {
  settingKey = "my-addon-debug",
  variableName = "debug",
  variableTable = MyAddonDB,
  name = "Debug output",
  tooltip = "Print additional diagnostic messages.",
  default = false,
  onClick = function()
    addon:PrintDebug("Debug setting changed.")
  end
})
```

## Slider

```lua
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
```

## Dropdown

```lua
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
```

## Expandable sections

```lua
local header, isExpanded = ArcaneWizardLibrary.Settings:AddExpandableHeader(layout, "Advanced")

ArcaneWizardLibrary.Settings:AddInfoText(layout, {
  leftText = "Advanced option",
  rightText = "Enabled",
  parentInit = header,
  parentCondition = isExpanded
})
```

Use `parentInit`, `parentCondition`, and `shownPredicate` to control visibility.

## Standard sections

Use built-in sections for common addon pages:

```lua
ArcaneWizardLibrary.Settings:AddProfilesSection(layout, {
  useAccountProfile = MyAddonDB.useAccountProfile,
  onSwitchProfile = SwitchProfileMode,
  onDeleteCharacterProfiles = DeleteCharacterProfiles
})

ArcaneWizardLibrary.Settings:AddAboutSection(layout, "MyAddon")
```
