# Arcane Wizard: Library

[![GitHub Release](https://img.shields.io/github/v/release/wow-addon-dev/Library?color=blue&logo=github&cacheSeconds=600)](https://github.com/wow-addon-dev/Library/releases) [![GitHub Release Date](https://img.shields.io/github/release-date/wow-addon-dev/Library?color=blue&logo=github&cacheSeconds=600)](https://github.com/wow-addon-dev/Library/releases) [![Static Badge](https://img.shields.io/badge/buy_me_a_coffe-donate-yellow?logo=buy-me-a-coffee&logoColor=white)](https://buymeacoffee.com/diomsg)

This addon is a library for World of Warcraft that bundles recurring code segments and functionalities. Originally developed to optimize the code of my own addons, it is designed to be easily utilized by other addon developers.

## For Players

This library does not have a standalone interface. Please install this addon only if it is required by another addon you are using. It ensures that those addons run efficiently and use common functions.

## For Developers

This library provides pre-built solutions for common addon functionalities.

### Included Functionalities

* **Dialogs:**
    * Link Dialog: Shows a popup with an auto-highlighted text field for easy copying.
    * Confirmation Dialog: A standard Yes/No prompt to safely confirm actions and execute callbacks.
* **Settings API Wrappers:** Easily add standard UI elements to the Blizzard options menu.
    * Buttons and static Info Text rows.
    * Checkboxes and Dropdown menus.
    * Combined Checkbox & Slider elements.
    * Expandable Headers to cleanly organize settings sections.

### How to Integrate

1.  Add the following to your `.toc` file:

    > `## Dependencies: ArcaneWizardLibrary`

2.  Set the dependency on the CurseForge project page to ensure users download it automatically.

## Supported Languages & Flavors

* Languages: English, German, Russian
* Flavors: Classic, Burning Crusade - Classic Anniversary Edition, Mists of Pandaria - Classic, Retail

## Bugs & Feedback

If you find a bug or have a suggestion, please use the GitHub Issues or the CurseForge comments.

## Translation Support

If you would like to localize this addon into other languages, your contribution would be very welcome. You can submit your translations directly via GitHub or use the [CurseForge Localization Tool](https://legacy.curseforge.com/wow/addons/arcane-wizard-library/localization).
