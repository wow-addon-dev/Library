# Getting Started

This guide assumes you are developing another World of Warcraft addon and want to use Arcane Wizard: Library as a dependency.

After the dependency is loaded, your addon can access the global `ArcaneWizardLibrary` table during normal addon initialization.

## Add the addon dependency

Add the library to your addon's `.toc` file so WoW loads it before your addon code:

```text
## Dependencies: ArcaneWizardLibrary
```

If you publish on CurseForge, configure the project dependency there as well so users receive the library automatically.

## Create an addon context

Create a context once during startup and reuse it from your addon modules. The context is the object most addon code should depend on:

```lua
local addonName = ...
local AWL = ArcaneWizardLibrary

local addon = AWL:NewAddon(addonName, {
  debugEnabled = function()
    return MyAddonDB and MyAddonDB.debug == true
  end
})
```

The context reads your addon's metadata and provides helpers for asset paths, chat output, settings navigation, minimap buttons, and AddonCompartment handlers.

## Access public namespaces

Use these public namespaces from your addon code:

| Namespace | Purpose |
| --- | --- |
| `ArcaneWizardLibrary` | Addon context factory and library metadata. |
| `ArcaneWizardLibrary.Utils` | General helper functions. |
| `ArcaneWizardLibrary.Dialogs` | Static popup helpers for links and confirmations. |
| `ArcaneWizardLibrary.Settings` | Blizzard settings UI wrappers. |

## Recommended first integration

Start with a context and debug-aware output. Add settings, dialogs, and launcher integration once the base context is in place:

```lua
local addon = ArcaneWizardLibrary:NewAddon("MyAddon", {
  debugEnabled = function()
    return MyAddonDB.debug
  end
})

addon:PrintMessage("Loaded.")
addon:PrintDebug("Debug output is enabled.")
```

Then add settings and launcher integration as needed.
