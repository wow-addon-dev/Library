# ArcaneWizardLibrary

`ArcaneWizardLibrary` is the public global exposed by the library.

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

Creates or returns the addon context for `addonName`.

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
