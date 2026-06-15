# Getting Started

Arcane Wizard: Library is loaded as a required addon dependency. Your addon can then access the global `ArcaneWizardLibrary` table during normal addon initialization.

## Add the addon dependency

Add the library to your addon's `.toc` file:

```toc
## Dependencies: ArcaneWizardLibrary
```

If you publish on CurseForge, also configure the project dependency there so users receive the library automatically.

## Create an addon context

Create a context once during startup and reuse it from your addon modules:

```lua
local addonName = ...
local AWL = ArcaneWizardLibrary

local addon = AWL:NewAddon(addonName, {
  debugEnabled = function()
    return MyAddonDB and MyAddonDB.debug == true
  end
})
```

The context stores addon metadata and provides helpers for asset paths, chat output, settings navigation, minimap buttons, and AddonCompartment handlers.

## Access public namespaces

The main public namespaces are:

| Namespace | Purpose |
| --- | --- |
| `ArcaneWizardLibrary` | Addon context factory and library metadata. |
| `ArcaneWizardLibrary.Utils` | General helper functions. |
| `ArcaneWizardLibrary.Dialogs` | Static popup helpers for links and confirmations. |
| `ArcaneWizardLibrary.Settings` | Blizzard settings UI wrappers. |

## Recommended first integration

Start with a context and a small settings category:

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
