# Utils API

`ArcaneWizardLibrary.Utils` contains general helper functions.

## `CopyTable(source)`

Creates a deep copy of a table by recursively copying nested tables.

```lua
local copy = ArcaneWizardLibrary.Utils:CopyTable(original)
```

## `GetCharacterAndRealm()`

Returns the current character name and realm name.

```lua
local characterName, realmName = ArcaneWizardLibrary.Utils:GetCharacterAndRealm()
```

## `GetCharacterRealmKey()`

Returns a stable character-realm key in the format `CharacterName#RealmName`.

```lua
local key = ArcaneWizardLibrary.Utils:GetCharacterRealmKey()
```
