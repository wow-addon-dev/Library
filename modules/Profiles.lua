local addonName, LIB = ...

local L = LIB.Localization

--- Returns the unique character key for the current player.
---
--- @return string charKey The character key in the format "CharacterName#RealmName".
function ArcaneWizardLibrary.Profiles:GetCharKey()
    return GetUnitName("player", true) .. "#" .. GetRealmName()
end

--- Returns a localized profile text by key suffix.
---
--- @param key string The profile localization key suffix.
---
--- @return string text The localized profile text.
function ArcaneWizardLibrary.Profiles:GetText(key)
    return L["profiles." .. key]
end

--- Returns the localized profile mode text.
---
--- @param useAccount boolean Whether the account-wide profile mode is active.
---
--- @return string text The localized profile mode text.
function ArcaneWizardLibrary.Profiles:GetModeText(useAccount)
    if useAccount then
        return self:GetText("mode.account")
    end

    return self:GetText("mode.character")
end

--- Returns the localized text for the profile switch button.
---
--- @param useAccount boolean Whether the account-wide profile mode is active.
---
--- @return string text The localized profile switch button text.
function ArcaneWizardLibrary.Profiles:GetSwitchButtonText(useAccount)
    if useAccount then
        return self:GetText("switch.button.account-to-character")
    end

    return self:GetText("switch.button.character-to-account")
end

--- Returns the localized confirmation text for switching profile mode.
---
--- @param useAccount boolean Whether the account-wide profile mode is active.
---
--- @return string text The localized profile switch confirmation text.
function ArcaneWizardLibrary.Profiles:GetSwitchConfirmText(useAccount)
    if useAccount then
        return self:GetText("switch.confirm.account-to-character")
    end

    return self:GetText("switch.confirm.character-to-account")
end
