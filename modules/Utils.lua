local _, LIB = ...

local L = LIB.Localization

------------------------
--- Public Functions ---
------------------------

--- Returns the unique character key for the current player.
---
--- @return string charKey The character key in the format "CharacterName#RealmName".
function ArcaneWizardLibrary.Utils:GetCharKey()
    local characterName, realmName

    if UnitFullName then
        characterName, realmName = UnitFullName("player")
    end

    characterName = characterName or UnitName("player") or "Unknown"
    realmName = realmName or GetRealmName() or "UnknownRealm"

    return characterName .. "#" .. realmName
end
