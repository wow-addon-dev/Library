local _, LIB = ...

LIB.Localization = setmetatable({},{__index=function(self,key)
        geterrorhandler()("Libraries (WoW Addon Development) (Debug): Missing entry for '" .. tostring(key) .. "'")
        return key
    end})

local L = LIB.Localization

-- Dialog

L["dialog.link.text"] = "To copy the link press CTRL + C."

-- Profiles

L["profiles.section-header"] = "Profiles"
L["profiles.profile-mode"] = "Active Profile"
L["profiles.mode.account"] = "Account Profile"
L["profiles.mode.character"] = "Character Profile"
L["profiles.switch.name"] = "Switch Profile Type"
L["profiles.switch.tooltip"] = "Switches between the account profile and character profile."
L["profiles.switch.button.account-to-character"] = "Use Character Profile"
L["profiles.switch.button.character-to-account"] = "Use Account Profile"
L["profiles.switch.confirm.account-to-character"] = "This character will use its own character profile after this. This change requires a UI reload. Do you want to continue?"
L["profiles.switch.confirm.character-to-account"] = "This character will use the account profile after this. This change requires a UI reload. Do you want to continue?"
L["profiles.delete-character-profiles.name"] = "Reset Character Profiles"
L["profiles.delete-character-profiles.button"] = "Delete Character Profiles"
L["profiles.delete-character-profiles.tooltip"] = "Deletes all character profiles and sets all characters to the account profile."
L["profiles.delete-character-profiles.confirm"] = "All character profiles will be deleted and all characters will use the account profile after this. Do you want to continue?"
