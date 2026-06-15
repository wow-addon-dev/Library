---
layout: home

hero:
  name: 'Arcane Wizard: Library'
  text: Shared WoW addon helpers for your addon.
  tagline: Integrate addon context, settings, dialogs, minimap buttons, and utility helpers without copying the same boilerplate into every project.
  image:
    src: /logo.png
    alt: Arcane Wizard Library logo
  actions:
    - theme: brand
      text: Get Started
      link: /getting-started
    - theme: alt
      text: API Reference
      link: /api/arcane-wizard-library

features:
  - title: Addon Context
    details: Create one reusable context for your addon and centralize metadata, media paths, debug output, and settings navigation.
  - title: Settings Wrappers
    details: Build Blizzard settings pages with checkboxes, sliders, dropdowns, info rows, profile controls, and about sections.
  - title: Dialog Helpers
    details: Show copyable link dialogs and confirmation prompts from your addon without duplicating StaticPopup setup.
  - title: Launcher Integration
    details: Register LibDataBroker minimap buttons and reuse AddonCompartment handlers with shared tooltip behavior.
---

## Who this documentation is for

This documentation is for World of Warcraft addon developers who want to use Arcane Wizard: Library as a dependency in their own addon.

The library is installed as a normal addon and consumed through the global `ArcaneWizardLibrary` table. Your addon declares the dependency, creates an addon context, and then uses the public helper namespaces where they fit.

## What you can build with it

Use the guides and API reference when you want to:

- create an addon context for metadata, asset paths, chat output, and debug output,
- build Blizzard settings pages with less repeated UI code,
- add standard profile and about sections,
- show confirmation or copy-link dialogs,
- register minimap and AddonCompartment entry points.

## Supported clients

The library currently targets Retail, Classic, Burning Crusade Classic Anniversary Edition, and Mists of Pandaria Classic. Supported languages are English, German, and Russian.
