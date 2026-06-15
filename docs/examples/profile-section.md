# Profile Section Example

The profiles section adds common controls for account-wide and character-specific profile modes.

```lua
local addonName = ...

MyAddonDB = MyAddonDB or {
  useAccountProfile = false
}

local addon = ArcaneWizardLibrary:NewAddon(addonName)

local category, layout = Settings.RegisterVerticalLayoutCategory("My Addon")
Settings.RegisterAddOnCategory(category)
addon:SetMainCategoryId(category:GetID())

local function SwitchProfileMode()
  MyAddonDB.useAccountProfile = not MyAddonDB.useAccountProfile
  ReloadUI()
end

local function DeleteCharacterProfiles()
  MyAddonCharacterProfiles = {}
  ReloadUI()
end

ArcaneWizardLibrary.Settings:AddProfilesSection(layout, {
  useAccountProfile = MyAddonDB.useAccountProfile,
  onSwitchProfile = SwitchProfileMode,
  onDeleteCharacterProfiles = DeleteCharacterProfiles
})
```

The section uses confirmation dialogs before running the supplied callbacks.
