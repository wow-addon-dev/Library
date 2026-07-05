# Basic Addon Example

This example shows the minimum setup for an addon that depends on Arcane Wizard: Library.

## `MyAddon.toc`

```text
## Interface: 120100
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

local addon = ArcaneWizardLibrary:NewAddon(addonName)
```

Use this as a base before adding settings or launcher support.
