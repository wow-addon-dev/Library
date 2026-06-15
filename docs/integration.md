# Integration

This page documents the expected integration points for addons that depend on Arcane Wizard: Library.

## Load order

The library is loaded by World of Warcraft through `ArcaneWizardLibrary.toc`. Public API tables are created in `ArcaneWizardLibrary.lua` and module files are included through `ArcaneWizardLibrary.xml`.

Your addon should declare:

```toc
## Dependencies: ArcaneWizardLibrary
```

Use `## OptionalDeps` only when your addon can run without the library and checks for `ArcaneWizardLibrary` before using it.

## Public global

The public entry point is:

```lua
ArcaneWizardLibrary
```

The library currently exposes:

```lua
ArcaneWizardLibrary.Utils
ArcaneWizardLibrary.Dialogs
ArcaneWizardLibrary.Settings
```

## Addon metadata

The library reads standard addon metadata with `C_AddOns.GetAddOnMetadata`. For best results, set these fields in your addon's `.toc`:

```toc
## Version: 1.0.0
## X-BuildDate: 2026-06-15
## X-Github: https://github.com/example/MyAddon
## X-Curseforge: https://www.curseforge.com/wow/addons/my-addon
```

`AddAboutSection` can use this metadata automatically when you pass your addon name.

## Asset convention

Addon contexts assume that addon assets live under:

```text
Interface\AddOns\<AddonName>\assets\
```

Use `addon:GetMediaPath("file.blp")` to build asset paths consistently.
