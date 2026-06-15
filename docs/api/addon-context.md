# Addon Context API

Addon contexts are created with `ArcaneWizardLibrary:NewAddon(addonName, config)`.

## Fields

| Field | Type | Description |
| --- | --- | --- |
| `name` | `string` | Addon folder name. |
| `version` | `string \| nil` | Addon version from `.toc` metadata. |
| `buildDate` | `string \| nil` | Addon build date from `X-BuildDate`. |
| `mediaPath` | `string` | Base path to the addon's `assets` folder. |
| `mainCategoryId` | `number \| nil` | Stored Blizzard settings category ID. |
| `debugEnabled` | `boolean \| function` | Debug output state or resolver function. |

## Methods

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
