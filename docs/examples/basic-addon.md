# Basic Addon Example

This example shows the minimum setup for an addon that depends on Arcane Wizard: Library.

## `MyAddon.toc`

```toc
## Interface: 120007
## Title: My Addon
## Author: Your Name
## Version: 1.0.0
## X-BuildDate: 2026-06-15
## Dependencies: ArcaneWizardLibrary
## SavedVariables: MyAddonDB

MyAddon.lua
```

## `MyAddon.lua`

```lua
local addonName = ...

MyAddonDB = MyAddonDB or {
  debug = false
}

local addon = ArcaneWizardLibrary:NewAddon(addonName, {
  debugEnabled = function()
    return MyAddonDB.debug == true
  end
})

addon:PrintMessage("Loaded.")
addon:PrintDebug("Debug output is enabled.")
```

Use this as a base before adding settings or launcher integration.
