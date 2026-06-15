# Addon Context

The addon context is the central object your addon receives from Arcane Wizard: Library. Create it once and pass or retrieve it wherever your addon needs shared helpers.

## Create a context

```lua
local addon = ArcaneWizardLibrary:NewAddon("MyAddon", {
  debugEnabled = function()
    return MyAddonDB.debug == true
  end
})
```

`debugEnabled` can be a boolean or a function that returns a boolean. A function is useful when the value lives in SavedVariables and can change at runtime.

## Reuse an existing context

```lua
local addon = ArcaneWizardLibrary:GetAddon("MyAddon")
```

`GetAddon` asserts if no context exists. Create the context in your addon's startup path before other modules request it.

## Media paths

```lua
local assetsPath = addon:GetMediaPath()
local iconPath = addon:GetMediaPath("icon-round.blp")
```

The returned path is based on your addon's `Interface\AddOns\<AddonName>\assets\` folder.

## Chat output

```lua
addon:PrintMessage("Options updated.")
addon:PrintDebug("Profile migration completed.")
```

`PrintDebug` only prints when the context's debug flag resolves to `true`.

## Settings navigation

Store the category ID after creating a Blizzard settings category:

```lua
addon:SetMainCategoryId(category:GetID())
```

Then open it from any supported launcher entry point:

```lua
addon:OpenCategory()
```

The library avoids opening the options panel during combat lockdown and returns `false` when it cannot open the category.
