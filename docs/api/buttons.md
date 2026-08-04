# Button Templates

Arcane Wizard: Library provides virtual XML templates with its own artwork so buttons look identical across supported game versions.

## Close buttons

The two close-button templates automatically hide their parent when clicked.

| Template | Size | Intended use |
| --- | --- | --- |
| `ArcaneWizardLibrary_WindowCloseButtonTemplate` | `18 x 18` | Large windows with an integrated title bar. |
| `ArcaneWizardLibrary_PopupCloseButtonTemplate` | `14 x 14` | Compact popups. |

```lua
local closeButton = CreateFrame(
  "Button",
  nil,
  window,
  "ArcaneWizardLibrary_WindowCloseButtonTemplate"
)
closeButton:SetPoint("TOPRIGHT", -3, -3)
```

Both templates provide normal, highlighted, pushed, and disabled visuals without relying on client-specific Blizzard button textures.

## Action button

`ArcaneWizardLibrary_ButtonTemplate` creates a button with a fixed height of `22` pixels and a variable width. Its minimum width is `44` pixels, and its default width is `100` pixels.

```lua
local button = CreateFrame(
  "Button",
  nil,
  window.content,
  "ArcaneWizardLibrary_ButtonTemplate"
)
button:SetWidth(120)
button:SetPoint("BOTTOMRIGHT")
button:SetText("Apply")
button:SetScript("OnClick", function()
  ApplyChanges()
end)
```

The template keeps its end caps unchanged when resized and provides normal, highlighted, pushed, and disabled states. Standard frame methods such as `SetWidth`, `SetText`, `Enable`, and `Disable` remain available.
