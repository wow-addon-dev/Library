local _, LIB = ...

if GetLocale() ~= "deDE" then return end

local L = LIB.Localization

-- Dialog

L["dialog.link.text"] = "Um den Link zu kopieren drücke STRG + C."

-- Profiles

L["profiles.section-header"] = "Profile"
L["profiles.profile-mode"] = "Aktives Profil"
L["profiles.mode.account"] = "Accountprofil"
L["profiles.mode.character"] = "Charakterprofil"
L["profiles.switch.name"] = "Profiltyp wechseln"
L["profiles.switch.tooltip"] = "Wechselt zwischen Accountprofil und Charakterprofil."
L["profiles.switch.button.account-to-character"] = "Charakterprofil nutzen"
L["profiles.switch.button.character-to-account"] = "Accountprofil nutzen"
L["profiles.switch.confirm.account-to-character"] = "Dieser Charakter nutzt danach ein eigenes Charakterprofil. Diese Änderung erfordert einen UI-Reload. Möchtest du fortfahren?"
L["profiles.switch.confirm.character-to-account"] = "Dieser Charakter nutzt danach das Accountprofil. Diese Änderung erfordert einen UI-Reload. Möchtest du fortfahren?"
L["profiles.delete-character-profiles.name"] = "Charakterprofile zurücksetzen"
L["profiles.delete-character-profiles.button"] = "Charakterprofile löschen"
L["profiles.delete-character-profiles.tooltip"] = "Löscht alle Charakterprofile und setzt alle Charaktere auf das Accountprofil."
L["profiles.delete-character-profiles.confirm"] = "Alle Charakterprofile werden gelöscht und alle Charaktere nutzen danach das Accountprofil. Möchtest du fortfahren?"
