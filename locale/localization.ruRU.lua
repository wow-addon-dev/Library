local _, LIB = ...

if GetLocale() ~= "ruRU" then return end

local L = LIB.Localization

-- Dialog

L["dialog.link.text"] = "Чтобы скопировать ссылку, нажмите CTRL + C."

-- Profiles

L["profiles.section-header"] = "Profiles"
L["profiles.profile-mode"] = "Active Profile"
L["profiles.mode.account"] = "Account Profile"
L["profiles.mode.character"] = "Character Profile"
L["profiles.switch.name"] = "Switch profile type"
L["profiles.switch.tooltip"] = "Switches between the account profile and character profile."
L["profiles.switch.button.account-to-character"] = "Use character profile"
L["profiles.switch.button.character-to-account"] = "Use account profile"
L["profiles.switch.confirm.account-to-character"] = "This character will use its own character profile afterwards. This change requires a UI reload. Do you want to continue?"
L["profiles.switch.confirm.character-to-account"] = "This character will use the account profile afterwards. This change requires a UI reload. Do you want to continue?"
L["profiles.delete-character-profiles.name"] = "Reset character profiles"
L["profiles.delete-character-profiles.button"] = "Delete character profiles"
L["profiles.delete-character-profiles.tooltip"] = "Deletes all character profiles and sets all characters to the account profile."
L["profiles.delete-character-profiles.confirm"] = "All character profiles will be deleted and all characters will use the account profile afterwards. Do you want to continue?"
