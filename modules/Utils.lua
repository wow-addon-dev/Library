local _, LIB = ...

local L = LIB.Localization

------------------------
--- Public Functions ---
------------------------

--- Returns the unique character key for the current player.
---
--- @return string charKey The character key in the format "CharacterName#RealmName".
function ArcaneWizardLibrary.Utils:GetCharKey()
    local characterName = UnitName("player")

    return characterName .. "#" .. GetRealmName()
end
