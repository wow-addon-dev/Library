# Settings Static API

`ArcaneWizardLibrary.Settings` is a static namespace. Call these helpers directly through `ArcaneWizardLibrary.Settings`; they are not methods on an addon context.

The namespace wraps common Blizzard settings UI patterns.

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

## `AddAboutSection(layout, addonName, changelog)`

Adds a standard about section. `layout` and `addonName` are required. Addon version, build date, author, and available project links are read from the addon's metadata.

The optional `changelog` parameter adds a localized changelog button. The button calls `Frames:OpenChangelog(addonName, changelog)`. Changelog windows are created separately for each addon on first use and then reused for that addon.

```lua
ArcaneWizardLibrary.Settings:AddAboutSection(layout, "MyAddon")
```

Structured changelog versions use the following fields:

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `version` | `string` | Yes | Non-empty version label. |
| `date` | `string` | No | Non-empty release or build date. |
| `entries` | `string[]` | Yes | Non-empty ordered list of non-empty changelog entries. |

```lua
ArcaneWizardLibrary.Settings:AddAboutSection(layout, "MyAddon", {
  {
    version = "Version 1.1.0",
    date = "2026-08-17",
    entries = {
      "Added: A new feature",
      "Fixed: An important issue"
    }
  }
})
```

CurseForge, Wago, and GitHub buttons are created only when their corresponding metadata fields are present and non-empty.
