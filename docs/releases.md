# Releases and Compatibility

Use this page when you decide which Arcane Wizard: Library version your addon should depend on.

## Recommended dependency model

For most addons, declare Arcane Wizard: Library as a required dependency:

```text
## Dependencies: ArcaneWizardLibrary
```

This keeps load order predictable and lets your addon call `ArcaneWizardLibrary` during startup without additional nil checks.

## Before updating your addon

When you update the library version used by your addon, check:

- whether the public API you call still exists,
- whether new helper behavior changes your settings or launcher flow,
- whether the supported WoW flavors match your addon targets,
- whether the release notes mention migration work for addon developers.

## Where release notes live

Release history is maintained in the repository and on GitHub releases:

- [GitHub Releases](https://github.com/wow-addon-dev/Library/releases)
- [CHANGELOG.md](https://github.com/wow-addon-dev/Library/blob/main/CHANGELOG.md)
- [FULL-CHANGELOG.md](https://github.com/wow-addon-dev/Library/blob/main/FULL-CHANGELOG.md)

This documentation focuses on how to use the library from another addon. It links to release notes instead of duplicating changelog entries.
