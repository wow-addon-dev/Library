# Controls Static API

`ArcaneWizardLibrary.Controls` creates consistently styled selection controls with Library-owned artwork. The controls therefore look identical across supported Retail and Classic clients.

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
