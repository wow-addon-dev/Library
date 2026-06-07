local addonName, LIB = ...

ArcaneWizardLibrary = ArcaneWizardLibrary or {}
ArcaneWizardLibrary.Utils = {}
ArcaneWizardLibrary.Dialogs = {}
ArcaneWizardLibrary.Settings = {}

ArcaneWizardLibrary.ADDON_AUTHOR = C_AddOns.GetAddOnMetadata(addonName, "Author")
ArcaneWizardLibrary.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
ArcaneWizardLibrary.ADDON_BUILD_DATE = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")
ArcaneWizardLibrary.ADDON_REVISION = C_AddOns.GetAddOnMetadata(addonName, "X-Revision")

ArcaneWizardLibrary.GAME_VERSION = GetBuildInfo()

ArcaneWizardLibrary.GAME_TYPE_VANILLA = (WOW_PROJECT_ID == WOW_PROJECT_CLASSIC)
ArcaneWizardLibrary.GAME_TYPE_TBC = (WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC)
---@diagnostic disable-next-line: undefined-global
ArcaneWizardLibrary.GAME_TYPE_MISTS = (WOW_PROJECT_ID == WOW_PROJECT_MISTS_CLASSIC)
ArcaneWizardLibrary.GAME_TYPE_MAINLINE = (WOW_PROJECT_ID == WOW_PROJECT_MAINLINE)

ArcaneWizardLibrary.GAME_FLAVOR = "unknown"

if ArcaneWizardLibrary.GAME_TYPE_VANILLA then
	ArcaneWizardLibrary.GAME_FLAVOR = "Classic"
elseif ArcaneWizardLibrary.GAME_TYPE_TBC then
	ArcaneWizardLibrary.GAME_FLAVOR = "Burning Crusade - Classic Anniversary Edition"
elseif ArcaneWizardLibrary.GAME_TYPE_MISTS then
	ArcaneWizardLibrary.GAME_FLAVOR = "Mists of Pandaria - Classic"
elseif ArcaneWizardLibrary.GAME_TYPE_MAINLINE then
	ArcaneWizardLibrary.GAME_FLAVOR = "Retail"
end
