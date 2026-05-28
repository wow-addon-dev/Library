local _, LIB = ...

------------------------
--- Public Functions ---
------------------------

--- Returns the unique character-realm key for the current player.
---
--- @return string characterRealmKey The character-realm key in the format "CharacterName#RealmName".
function ArcaneWizardLibrary.Utils:GetCharacterRealmKey()
	local characterName = UnitName("player")
	local realmName = GetRealmName()

	return characterName .. "#" .. realmName
end
