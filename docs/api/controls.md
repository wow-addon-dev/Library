# Controls Static API

`ArcaneWizardLibrary.Controls` creates consistently styled buttons, selection controls, and dropdown menus with Library-owned artwork. The controls therefore look identical across supported Retail and Classic clients.

## Action Button

### `CreateButton(parent, width, label, onClick)`

Creates an action button based on `ArcaneWizardLibrary_ActionButtonTemplate`. The height is fixed at `22` pixels, while the width can be set to any value of at least `44` pixels.

| Parameter | Type | Description |
| --- | --- | --- |
| `parent` | `Frame` | Parent frame for the button. |
| `width` | `number` | Button width. Must be at least `44` pixels. |
| `label` | `string` | Non-empty displayed label. |
| `onClick` | `function \| nil` | Receives `button`, `mouseButton`, and `down` when clicked. |

```lua
local button = ArcaneWizardLibrary.Controls:CreateButton(
  window.content,
  120,
  "Apply",
  function()
    ApplyChanges()
  end
)
button:SetPoint("BOTTOMRIGHT")
```

The returned button supports standard methods such as `SetWidth`, `SetText`, `Enable`, and `Disable` and provides normal, highlighted, pushed, and disabled visuals.

## Close Buttons

Windows and popups use two controls that automatically hide their parent when clicked:

| Template | Size | Intended use |
| --- | --- | --- |
| `ArcaneWizardLibrary_WindowCloseButtonTemplate` | `18 x 18` | Large windows with an integrated title bar. |
| `ArcaneWizardLibrary_PopupCloseButtonTemplate` | `14 x 14` | Compact popups. |

Both templates provide normal, highlighted, pushed, and disabled visuals without relying on client-specific Blizzard artwork.

## Checkbox

### `CreateCheckbox(parent, width, label, checked, onValueChanged)`

Creates a checkbox based on `ArcaneWizardLibrary_CheckboxTemplate`.

| Parameter | Type | Description |
| --- | --- | --- |
| `parent` | `Frame` | Parent frame for the checkbox. |
| `width` | `number` | Checkbox width. Must be at least `44` pixels. |
| `label` | `string` | Non-empty displayed label. |
| `checked` | `boolean` | Initial checked state. |
| `onValueChanged` | `function \| nil` | Receives `checked` and `checkbox` after a user changes the value. |

```lua
local checkbox = ArcaneWizardLibrary.Controls:CreateCheckbox(
  window.content,
  180,
  "Enable feature",
  true,
  function(checked)
    settings.featureEnabled = checked
  end
)
checkbox:SetPoint("TOPLEFT", 24, -24)
```

The returned checkbox supports the standard `SetChecked`, `GetChecked`, `Enable`, and `Disable` methods.

## Option Group

### `CreateOptionGroup(parent, width, options, selectedValue, onValueChanged)`

Creates a vertical group of mutually exclusive options based on `ArcaneWizardLibrary_OptionButtonTemplate`. Clicking the selected option does not clear it, so exactly one option remains selected.

| Parameter | Type | Description |
| --- | --- | --- |
| `parent` | `Frame` | Parent frame for the option group. |
| `width` | `number` | Width of every option. Must be at least `44` pixels. |
| `options` | `table[]` | Ordered options containing unique `label` and `value` fields. |
| `selectedValue` | `string \| number \| boolean` | Initial value matching one option. |
| `onValueChanged` | `function \| nil` | Receives `value`, `option`, and `group` after a user changes the selection. |

```lua
local group = ArcaneWizardLibrary.Controls:CreateOptionGroup(
  window.content,
  180,
  {
    { label = "Account", value = "account" },
    { label = "Character", value = "character" }
  },
  "account",
  function(value)
    settings.scope = value
  end
)
group:SetPoint("TOPLEFT", 24, -64)
```

The returned group provides:

| Method | Description |
| --- | --- |
| `GetValue()` | Returns the selected option value. |
| `SetValue(value)` | Selects the matching option without calling `onValueChanged`. |
| `SetEnabled(enabled)` | Enables or disables every option in the group. |

Both controls provide normal, highlighted, pushed, selected, and disabled visuals without using client-specific Blizzard artwork.

## Dropdown Menu

### `CreateDropdown(parent, width, options, selectedValue, onValueChanged)`

Creates a dropdown menu based on `ArcaneWizardLibrary_DropdownTemplate`. It supports selectable values, dividers, optional icons, nested option groups, and long mouse-wheel-scrollable menus.

| Parameter | Type | Description |
| --- | --- | --- |
| `parent` | `Frame` | Parent frame for the dropdown. |
| `width` | `number` | Dropdown width and minimum menu width. Must be at least `80` pixels. Menus expand up to `320` pixels for longer labels. |
| `options` | `table[] \| function` | Static options or a function returning the current options. |
| `selectedValue` | `string \| number \| boolean \| nil` | Initial selected value or `nil`. |
| `onValueChanged` | `function \| nil` | Receives `value`, `option`, and `dropdown` after a user changes the selection. |

Option entries use one of these forms:

```lua
{ label = "Gold", value = "gold", icon = 237618 }
{ divider = true }
{
  label = "Currencies",
  children = {
    { label = "Currency A", value = "currency-a" },
    { label = "Currency B", value = "currency-b", disabled = true }
  }
}
```

Values must be unique throughout the complete menu. `icon` accepts texture paths or file IDs, while `atlas` accepts an atlas name. Entries may also define `textColor = { red, green, blue }` for labels such as class-colored character names.

```lua
local dropdown = ArcaneWizardLibrary.Controls:CreateDropdown(
  window.content,
  200,
  function()
    return BuildCurrentOptions()
  end,
  "gold",
  function(value)
    selectedCurrency = value
  end
)
dropdown:SetPoint("TOPLEFT", 24, -120)
```

The returned dropdown provides:

| Method | Description |
| --- | --- |
| `GetValue()` | Returns the selected option value. |
| `SetValue(value)` | Selects a value or clears the selection with `nil` without calling `onValueChanged`. |
| `SetOptions(options)` | Replaces the static options or dynamic provider. |
| `SetDefaultText(text)` | Changes the text displayed without a selection. |
| `SetEmptyText(text)` | Changes the text displayed by an empty menu. |
| `GenerateMenu()` | Refreshes dynamic options and the displayed selection. |
| `OpenMenu()` / `CloseMenu()` | Opens or closes the menu. |

The dropdown uses no Blizzard dropdown templates, so its button, menu rows, submenus, and scrolling remain consistent across supported clients.
