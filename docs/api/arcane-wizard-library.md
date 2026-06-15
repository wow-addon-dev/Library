# Addon API

`ArcaneWizardLibrary` is the public global exposed by the library. This page covers the addon-specific API: create an addon context, then call methods on the returned `addon` object.

`ArcaneWizardLibrary.Settings`, `ArcaneWizardLibrary.Dialogs`, and `ArcaneWizardLibrary.Utils` are static namespaces and are documented on their own API pages.

## Metadata

| Field | Type | Description |
| --- | --- | --- |
| `ADDON_AUTHOR` | `string` | Author from the library `.toc`. |
| `ADDON_VERSION` | `string` | Library version from the library `.toc`. |
| `ADDON_BUILD_DATE` | `string` | Build date from `X-BuildDate`. |
| `ADDON_REVISION` | `string` | Revision from `X-Revision`. |
| `GAME_VERSION` | `string` | Current WoW build string from `GetBuildInfo()`. |
| `GAME_FLAVOR` | `string` | Human-readable flavor name. |
| `GAME_TYPE_VANILLA` | `boolean` | `true` on Classic Era. |
| `GAME_TYPE_TBC` | `boolean` | `true` on Burning Crusade Classic Anniversary Edition. |
| `GAME_TYPE_MISTS` | `boolean` | `true` on Mists of Pandaria Classic. |
| `GAME_TYPE_MAINLINE` | `boolean` | `true` on Retail. |

## Namespaces

| Namespace | Description |
| --- | --- |
| `ArcaneWizardLibrary.Utils` | General utility helpers. |
| `ArcaneWizardLibrary.Dialogs` | Static popup helpers. |
| `ArcaneWizardLibrary.Settings` | Blizzard settings helpers. |

## `ArcaneWizardLibrary:NewAddon(addonName, config)`

Creates or returns the addon context for `addonName`. This context is the main object a consuming addon uses for addon-specific helpers.

```lua
local addon = ArcaneWizardLibrary:NewAddon("MyAddon", {
  debugEnabled = false
})
```

### Parameters

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `addonName` | `string` | Yes | The addon's folder name. |
| `config` | `table` | No | Optional context configuration. |
| `config.debugEnabled` | `boolean \| function` | No | Enables debug output or resolves it dynamically. |

### Returns

`ArcaneWizardLibraryAddon`

## `ArcaneWizardLibrary:GetAddon(addonName)`

Returns an existing addon context.

```lua
local addon = ArcaneWizardLibrary:GetAddon("MyAddon")
```

This function asserts if no context has been created for the given addon name.

## Addon context

Addon contexts are created with `ArcaneWizardLibrary:NewAddon(addonName, config)` and returned by `ArcaneWizardLibrary:GetAddon(addonName)`.

### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `string` | Addon folder name. |
| `version` | `string \| nil` | Addon version from `.toc` metadata. |
| `buildDate` | `string \| nil` | Addon build date from `X-BuildDate`. |
| `mediaPath` | `string` | Base path to the addon's `assets` folder. |
| `mainCategoryId` | `number \| nil` | Stored Blizzard settings category ID. |
| `debugEnabled` | `boolean \| function` | Debug output state or resolver function. |

### `addon:GetMediaPath(fileName)`

Returns the base media path or a specific file path below it.

```lua
local icon = addon:GetMediaPath("icon-round.blp")
```

### `addon:SetMainCategoryId(categoryId)`

Stores the Blizzard settings category ID for later use with `OpenCategory`.

```lua
addon:SetMainCategoryId(category:GetID())
```

### `addon:OpenCategory()`

Opens the stored settings category when combat lockdown does not block it.

Returns `true` when the category was opened and `false` otherwise.

### `addon:PrintMessage(msg)`

Prints a normal addon chat message.

### `addon:PrintDebug(msg)`

Prints a debug message only when debug output is enabled.

### `addon:RegisterMinimapButton(config)`

Registers a LibDataBroker minimap button and returns the LibDBIcon instance.

### `addon:CreateCompartmentHandlers(config)`

Creates a table with `OnEnter`, `OnLeave`, and `OnClick` handlers for AddonCompartment integration.
