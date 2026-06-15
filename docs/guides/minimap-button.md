# Minimap Button

Addon contexts provide a small wrapper around LibDataBroker and LibDBIcon for addons that need a minimap launcher.

## Register a minimap button

```lua
local addon = ArcaneWizardLibrary:NewAddon("MyAddon")

MyAddonDB.minimap = MyAddonDB.minimap or {}

addon:RegisterMinimapButton({
  db = MyAddonDB.minimap,
  iconFileName = "icon-round.blp",
  tooltip = {
    "Left-click to open the main window.",
    "Right-click to open settings."
  },
  onLeftClick = function()
    ToggleMyAddonWindow()
  end
})
```

Right-click opens your stored settings category through `addon:OpenCategory()`.

## Tooltip behavior

The tooltip shows:

1. The addon name.
2. The addon version and build date.
3. Custom tooltip lines from `config.tooltip`.

`config.tooltip` can be a string or an array of strings.

## AddonCompartment handlers

Use the same click and tooltip behavior for AddonCompartment entries:

```lua
local handlers = addon:CreateCompartmentHandlers({
  tooltip = "Open MyAddon.",
  onLeftClick = function()
    ToggleMyAddonWindow()
  end
})
```

Assign the returned `OnEnter`, `OnLeave`, and `OnClick` functions to the AddonCompartment registration code used by your addon flavor.
