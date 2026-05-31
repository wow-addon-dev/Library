local _, LIB = ...

------------------------
--- Public Functions ---
------------------------

--- Creates a deep copy of a table.
---
--- Handles cyclic references and preserves metatables.
---
--- @param source any The value to copy. Non-table values are returned unchanged.
--- @param seen table|nil Internal cache used for cyclic table references.
---
--- @return any copy The copied value.
function ArcaneWizardLibrary.Utils:CopyTable(source, seen)
	if type(source) ~= "table" then
		return source
	end

	seen = seen or {}

	if seen[source] then
		return seen[source]
	end

	local target = {}
	seen[source] = target

	for key, value in pairs(source) do
		target[self:CopyTable(key, seen)] = self:CopyTable(value, seen)
	end

	return setmetatable(target, getmetatable(source))
end

--- Returns the unique character-realm key for the current player.
---
--- @return string characterRealmKey The character-realm key in the format "CharacterName#RealmName".
function ArcaneWizardLibrary.Utils:GetCharacterRealmKey()
	local characterName = UnitName("player")
	local realmName = GetRealmName()

	return characterName .. "#" .. realmName
end
