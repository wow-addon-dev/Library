local _, LIB = ...

local AddonChat = LIB.Internal.AddonChat

--------------------------
--- Internal Functions ---
--------------------------

function AddonChat:PrintMessage(addon, msg)
	DEFAULT_CHAT_FRAME:AddMessage(NORMAL_FONT_COLOR:WrapTextInColorCode(addon.name .. ": ") .. tostring(msg))
end

function AddonChat:PrintDebug(addon, msg, enabled)
	if enabled == true then
		DEFAULT_CHAT_FRAME:AddMessage(ORANGE_FONT_COLOR:WrapTextInColorCode(addon.name .. " (Debug): ") .. tostring(msg))
	end
end
