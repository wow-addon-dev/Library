local _, LIB = ...

------------------------
--- Public Functions ---
------------------------

--- Creates a deep copy of a table.
---
--- Copies nested table values recursively.
--- Intended for plain, acyclic SavedVariables-style tables.
--- Metatables are not preserved and cyclic references are not supported.
---
--- @param source table The table to copy.
---
--- @return table copy The copied table.
function ArcaneWizardLibrary.Utils:CopyTable(source)
	local target = {}

	for key, value in pairs(source) do
		if type(value) == "table" then
			target[key] = self:CopyTable(value)
		else
			target[key] = value
		end
	end

	return target
end

--- Returns the character and realm name of the current player as separate values.
---
--- @return string characterName The character name.
--- @return string realmName The realm name.
function ArcaneWizardLibrary.Utils:GetCharacterAndRealm()
	local characterName = UnitName("player")
	local realmName = GetRealmName()

	return characterName, realmName
end

--- Returns the unique character-realm key for the current player.
---
--- @return string characterRealmKey The character-realm key in the format "CharacterName#RealmName".
function ArcaneWizardLibrary.Utils:GetCharacterRealmKey()
	local characterName, realmName = self:GetCharacterAndRealm()

	return characterName .. "#" .. realmName
end
