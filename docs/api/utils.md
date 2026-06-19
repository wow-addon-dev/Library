# Utils Static API

`ArcaneWizardLibrary.Utils` is a static namespace. Call these helpers directly through `ArcaneWizardLibrary.Utils`; they are not methods on an addon context.

The namespace contains general helper functions.

## `CopyTable(source)`

Creates a deep copy of a table by recursively copying nested tables.

```lua
local copy = ArcaneWizardLibrary.Utils:CopyTable(original)
```

This helper is intended for plain, acyclic SavedVariables-style tables. It does not preserve metatables and does not detect reference cycles.

## `GetCharacterAndRealm()`

Returns the current character name and realm name.

```lua
local characterName, realmName = ArcaneWizardLibrary.Utils:GetCharacterAndRealm()
```

Use this helper when the character and realm are needed as separate values.

## `GetCharacterRealmKey()`

Returns a stable character-realm key in the format `CharacterName#RealmName`.

```lua
local key = ArcaneWizardLibrary.Utils:GetCharacterRealmKey()
```

This helper intentionally returns only the combined key. Use `GetCharacterAndRealm()` when you need separate `characterName` and `realmName` values.
