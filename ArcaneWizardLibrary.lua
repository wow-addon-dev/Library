local addonName, LIB = ...

ArcaneWizardLibrary = ArcaneWizardLibrary or {}
ArcaneWizardLibrary.Utils = {}
ArcaneWizardLibrary.Dialogs = {}
ArcaneWizardLibrary.Settings = {}

ArcaneWizardLibrary.ADDON_AUTHOR = C_AddOns.GetAddOnMetadata(addonName, "Author")
ArcaneWizardLibrary.ADDON_VERSION = C_AddOns.GetAddOnMetadata(addonName, "Version")
ArcaneWizardLibrary.ADDON_BUILD_DATE = C_AddOns.GetAddOnMetadata(addonName, "X-BuildDate")
