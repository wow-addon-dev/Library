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

## `ArcaneWizardLibrary:NewAddon(addonName)`

Creates or returns the addon context for `addonName`. This context is the main object a consuming addon uses for addon-specific helpers.

```lua
local addon = ArcaneWizardLibrary:NewAddon("MyAddon")
```

### Parameters

| Name | Type | Required | Description |
| --- | --- | --- | --- |
| `addonName` | `string` | Yes | The addon's folder name. |

### Returns

`ArcaneWizardLibraryAddon`

## `ArcaneWizardLibrary:GetAddon(addonName)`

Returns an existing addon context.

```lua
local addon = ArcaneWizardLibrary:GetAddon("MyAddon")
```

This function asserts if no context has been created for the given addon name.

## Addon context

Addon contexts are created with `ArcaneWizardLibrary:NewAddon(addonName)` and returned by `ArcaneWizardLibrary:GetAddon(addonName)`.

### Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `string` | Addon folder name. |
| `version` | `string \| nil` | Addon version from `.toc` metadata. |
| `buildDate` | `string \| nil` | Addon build date from `X-BuildDate`. |
| `mediaPath` | `string` | Base path to the addon's `assets` folder. |
| `mainCategoryId` | `number \| nil` | Stored Blizzard settings category ID. |

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

Returns `true` when the category was opened and `false` when combat lockdown blocks opening the options menu.

This function asserts when no category ID has been stored with `SetMainCategoryId`, because that indicates an addon integration error.

### `addon:RegisterMinimapButton(config)`

Registers a LibDataBroker minimap button and returns the LibDBIcon instance.

The launcher tooltip shows the addon name and includes `version` and `buildDate` when the corresponding optional addon metadata is available. Missing metadata is omitted.

| Config field | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `db` | `table` | No | None | LibDBIcon configuration table used to store visibility and minimap position. |
| `tooltip` | `string \| string[]` | No | None | One tooltip line or a list of tooltip lines displayed below the addon metadata. |
| `iconFileName` | `string` | No | `icon-round.blp` | File name below the addon's `assets` folder used as the launcher icon. |
| `onLeftClick` | `function` | No | None | Callback invoked when the launcher is left-clicked. A right-click opens the addon's settings category. |

### `addon:CreateCompartmentHandlers(config)`

Creates a table with `OnEnter`, `OnLeave`, and `OnClick` handlers for AddonCompartment integration.

The AddonCompartment tooltip uses the same optional `version` and `buildDate` metadata as the minimap launcher.

| Config field | Type | Required | Default | Description |
| --- | --- | --- | --- | --- |
| `tooltip` | `string \| string[]` | No | None | One tooltip line or a list of tooltip lines displayed below the addon metadata. |
| `onLeftClick` | `function` | No | None | Callback invoked when the compartment entry is left-clicked. A right-click opens the addon's settings category. |
