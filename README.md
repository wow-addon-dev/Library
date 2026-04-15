# Arcane Wizard: Library

[![GitHub Release](https://img.shields.io/github/v/release/wow-addon-dev/Library?color=blue&logo=github&cacheSeconds=600)](https://github.com/wow-addon-dev/Library/releases)
[![GitHub Release Date](https://img.shields.io/github/release-date/wow-addon-dev/Library?color=blue&logo=github&cacheSeconds=600)](https://github.com/wow-addon-dev/Library/releases)
[![Static Badge](https://img.shields.io/badge/buy_me_a_coffe-donate-yellow?logo=buy-me-a-coffee&logoColor=white)](https://buymeacoffee.com/diomsg)

This addon is a library for World of Warcraft that bundles recurring code segments and functionalities. Originally developed to optimize the code of my own addons, it is designed to be easily utilized by any addon developer.

***

**Important Note for Players**

This library and does not have a standalone interface. Please install this addon only if it is required by another addon you are using. It ensures that those addons run efficiently and share core logic to minimize memory usage.

***

**For Developers**

This library provides pre-built solutions for common UI tasks that are often tedious to implement from scratch.

**Features:**

*   Link Handling Dialogs: Easy-to-use dialog windows for displaying and copying URLs/links to the user.
*   Safe Code Execution: A standardized confirmation dialog system for executing code snippets after explicit user approval.
*   Options Menu Extensions: Specialized modules for the modern Blizzard Settings (Options) API that allow for the easy insertion of plain text lines/labels, making it easier to create informative and structured config panels.

**How to integrate:**

1.  Add the following to your `.toc` file:

    > ## Dependencies: ArcaneWizardLibrary

2.  Set the dependency on the CurseForge project page to ensure users download it automatically.
