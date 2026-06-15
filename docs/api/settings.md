# Settings API

`ArcaneWizardLibrary.Settings` wraps common Blizzard settings UI patterns.

## Shared config keys

Several helpers accept these optional keys:

| Key | Type | Description |
| --- | --- | --- |
| `parentInit` | `table` | Parent initializer for nested visibility. |
| `parentCondition` | `function` | Predicate used with `parentInit`. |
| `shownPredicate` | `function` | Additional visibility predicate. |
| `onClick` | `function` | Value changed callback for registered settings. |

## `AddButton(layout, config)`

Adds a clickable button row.

Required config keys: `name`, `buttonText`, `onClick`.

Optional config key: `tooltip`.

Returns the button initializer.

## `AddInfoText(layout, config)`

Adds a static key-value text row.

Required config keys: `leftText`, `rightText`.

Optional config key: `height`. Supported named heights are `compact` and `default`.

Returns the text initializer.

## `AddCheckbox(category, config)`

Registers and adds a boolean checkbox.

Required config keys: `settingKey`, `variableName`, `variableTable`, `name`, `tooltip`.

Optional config key: `default`.

Returns `initializer, setting`.

## `AddSlider(category, config)`

Registers and adds a numeric slider.

Required config keys: `settingKey`, `variableName`, `variableTable`, `name`, `tooltip`.

Optional config keys: `default`, `minValue`, `maxValue`, `step`, `formatter`.

Returns `initializer, setting`.

## `AddCheckboxSliderCombo(category, layout, config)`

Registers and adds a combined checkbox and slider row.

Required config keys include:

| Key | Description |
| --- | --- |
| `variableTable` | SavedVariables table used by both settings. |
| `checkboxSettingKey` | Settings registry key for the checkbox. |
| `checkboxVariableName` | SavedVariables key for the checkbox. |
| `checkboxName` | Checkbox label. |
| `sliderSettingKey` | Settings registry key for the slider. |
| `sliderVariableName` | SavedVariables key for the slider. |
| `sliderName` | Slider label. |

Optional slider keys: `sliderDefault`, `sliderMin`, `sliderMax`, `sliderStep`, `sliderFormatter`.

Returns `initializer, settingCheckbox, settingSlider`.

## `AddDropdown(category, config)`

Registers and adds a dropdown.

Required config keys: `settingKey`, `variableName`, `variableTable`, `name`, `tooltip`, `default`, `options`.

`options` is an array of `{ value, label }` tables.

Returns `initializer, setting`.

## `AddExpandableHeader(layout, name)`

Adds an expandable header and returns `initializer, isExpandedPredicate`.

Use the returned predicate as `parentCondition` for child rows.

## `AddProfilesSection(layout, config)`

Adds a standard profiles section.

Required config keys: `useAccountProfile`, `onSwitchProfile`, `onDeleteCharacterProfiles`.

## `AddAboutSection(layout, addonNameOrConfig)`

Adds a standard about section.

Pass an addon name to read metadata automatically:

```lua
ArcaneWizardLibrary.Settings:AddAboutSection(layout, "MyAddon")
```

Or pass explicit values:

```lua
ArcaneWizardLibrary.Settings:AddAboutSection(layout, {
  addonName = "MyAddon",
  addonVersion = "1.0.0",
  addonBuildDate = "2026-06-15",
  addonAuthor = "Arcane Wizard",
  curseforgeLink = "https://www.curseforge.com/wow/addons/my-addon",
  githubLink = "https://github.com/example/MyAddon"
})
```
