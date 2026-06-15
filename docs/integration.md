# Integration

Use this page when you wire Arcane Wizard: Library into your own addon package.

## Load order

The library is loaded by World of Warcraft through `ArcaneWizardLibrary.toc`. Your addon should let WoW load the library first and then use the public global during your own startup.

Your addon should declare:

```text
## Dependencies: ArcaneWizardLibrary
```

Use `## OptionalDeps` only when your addon can run without the library and checks for `ArcaneWizardLibrary` before calling it. For normal usage, prefer `## Dependencies`.

## Public global

The public entry point for your addon is:

```lua
ArcaneWizardLibrary
```

The library currently exposes these helper namespaces:

```lua
ArcaneWizardLibrary.Utils
ArcaneWizardLibrary.Dialogs
ArcaneWizardLibrary.Settings
```

## Addon metadata

Several helpers read your addon's metadata with `C_AddOns.GetAddOnMetadata`. For best results, set these fields in your addon's `.toc`:

```text
## Version: 1.0.0
## X-BuildDate: 2026-06-15
## X-Github: https://github.com/example/MyAddon
## X-Curseforge: https://www.curseforge.com/wow/addons/my-addon
```

`AddAboutSection` can use this metadata automatically when your addon passes its own addon name.

## Asset convention

Addon contexts assume your addon assets live under:

```text
Interface\AddOns\<AddonName>\assets\
```

Use `addon:GetMediaPath("file.blp")` instead of hardcoding asset paths in multiple addon modules.
