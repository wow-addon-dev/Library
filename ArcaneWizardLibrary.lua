local addonName, LIB = ...

LIB.Internal = LIB.Internal or {}
LIB.Internal.AddonChat = {}
LIB.Internal.AddonLauncher = {}

ArcaneWizardLibrary = ArcaneWizardLibrary or {}

local AWL = ArcaneWizardLibrary

AWL.Utils = {}
AWL.Dialogs = {}
AWL.Settings = {}

AWL.ADDON_AUTHOR = C_AddOns.GetAddOnMetadata(addonName, "Author")
AWL.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
AWL.ADDON_BUILD_DATE = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")
AWL.ADDON_REVISION = C_AddOns.GetAddOnMetadata(addonName, "X-Revision")

AWL.GAME_VERSION = GetBuildInfo()

AWL.GAME_TYPE_VANILLA = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
AWL.GAME_TYPE_TBC = (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)
---@diagnostic disable-next-line: undefined-global
AWL.GAME_TYPE_MISTS = (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC)
AWL.GAME_TYPE_MAINLINE = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)

AWL.GAME_FLAVOR = "unknown"

if AWL.GAME_TYPE_VANILLA then
	AWL.GAME_FLAVOR = "Classic"
elseif AWL.GAME_TYPE_TBC then
	AWL.GAME_FLAVOR = "Burning Crusade - Classic Anniversary Edition"
elseif AWL.GAME_TYPE_MISTS then
	AWL.GAME_FLAVOR = "Mists of Pandaria - Classic"
elseif AWL.GAME_TYPE_MAINLINE then
	AWL.GAME_FLAVOR = "Retail"
end
