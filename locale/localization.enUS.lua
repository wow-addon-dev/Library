local _, LIB = ...

LIB.Localization = setmetatable({},{__index=function(self,key)
		geterrorhandler()("Arcane Wizard: Library (Debug): Missing entry for '" .. tostring(key) .. "'")
		return key
	end})

local L = LIB.Localization

-- Dialog

L["dialog.link.text"] = "To copy the link press CTRL + C."

-- Profiles

L["settings.profiles.section-header"] = "Profiles"
L["settings.profiles.profile-mode"] = "Active Profile"
L["settings.profiles.mode.account"] = "Account Profile"
L["settings.profiles.mode.character"] = "Character Profile"
L["settings.profiles.switch.name"] = "Switch Profile Type"
L["settings.profiles.switch.tooltip"] = "Switches between the account profile and character profile."
L["settings.profiles.switch.button.account-to-character"] = "Use Character Profile"
L["settings.profiles.switch.button.character-to-account"] = "Use Account Profile"
L["settings.profiles.switch.confirm.account-to-character"] = "This character will use its own character profile after this. This change requires a UI reload. Do you want to continue?"
L["settings.profiles.switch.confirm.character-to-account"] = "This character will use the account profile after this. This change requires a UI reload. Do you want to continue?"
L["settings.profiles.delete-character-profiles.name"] = "Reset Character Profiles"
L["settings.profiles.delete-character-profiles.button"] = "Delete Character Profiles"
L["settings.profiles.delete-character-profiles.tooltip"] = "Deletes all character profiles and sets all characters to the account profile."
L["settings.profiles.delete-character-profiles.confirm"] = "All character profiles will be deleted and all characters will use the account profile after this. Do you want to continue?"

-- About

L["settings.about"] = "About"
L["settings.about.game-version"] = "Game Version"
L["settings.about.addon-version"] = "Addon Version"
L["settings.about.lib-version"] = "Library Version"
L["settings.about.author"] = "Author"
L["settings.about.button-curseforge.name"] = "Download & Updates"
L["settings.about.button-curseforge.tooltip"] = "Opens a popup window with a link to CurseForge."
L["settings.about.button-curseforge.button"] = "CurseForge"
L["settings.about.button-github.name"] = "Feedback & Help"
L["settings.about.button-github.tooltip"] = "Opens a popup window with a link to GitHub."
L["settings.about.button-github.button"] = "GitHub"
