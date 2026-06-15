# Releases and Compatibility

Use this page when you decide which Arcane Wizard: Library version your addon should depend on.

## Recommended dependency model

For most addons, declare Arcane Wizard: Library as a required dependency:

```text
## Dependencies: ArcaneWizardLibrary
```

This keeps load order predictable and lets your addon call `ArcaneWizardLibrary` during startup without additional nil checks.

## Compatibility expectations

Addons should use the documented public API only. Internal files, internal namespaces, and bundled third-party libraries are implementation details and can change between releases.

For addon developers, the relevant compatibility surface is:

- the global `ArcaneWizardLibrary` table,
- the documented `Utils`, `Dialogs`, and `Settings` namespaces,
- addon contexts created with `ArcaneWizardLibrary:NewAddon`,
- the supported WoW flavors listed on the overview page.

Breaking changes and required migration steps are documented in the release notes when they affect addon developers.

## Where release notes live

Release history is maintained in the repository and on GitHub releases:

- [GitHub Releases](https://github.com/wow-addon-dev/Library/releases)
- [CHANGELOG.md](https://github.com/wow-addon-dev/Library/blob/main/CHANGELOG.md)
- [FULL-CHANGELOG.md](https://github.com/wow-addon-dev/Library/blob/main/FULL-CHANGELOG.md)

This documentation focuses on how to use the library from another addon. It links to release notes instead of duplicating changelog entries.
