local _, LIB = ...

local L = LIB.Localization
local AddonUpdateNotice = LIB.Internal.AddonUpdateNotice

------------------------
--- Module Functions ---
------------------------

function AddonUpdateNotice:Show(addon, show)
	assert(type(show) == "boolean", "Arcane Wizard: Library (Debug): No update notice visibility defined for " .. tostring(addon.name) .. ".")

	if not show then
		return false
	end

	assert(type(addon.version) == "string" and addon.version ~= "", "Arcane Wizard: Library (Debug): No addon version defined for " .. tostring(addon.name) .. ".")

	local prefix = NORMAL_FONT_COLOR:WrapTextInColorCode(addon.name .. ": ")

	DEFAULT_CHAT_FRAME:AddMessage(prefix .. string.format(L["chat.update-notice"], addon.version))

	return true
end
