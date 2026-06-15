---
layout: home

hero:
  name: 'Arcane Wizard: Library'
  text: Shared WoW addon helpers for addon context, settings, dialogs, and launcher integration.
  tagline: Developer documentation for building addons on top of ArcaneWizardLibrary.
  image:
    src: /logo.svg
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
    details: Create one reusable context per addon and centralize metadata, media paths, debug output, and settings navigation.
  - title: Settings Wrappers
    details: Add Blizzard settings rows for checkboxes, sliders, dropdowns, info text, profile controls, and about sections.
  - title: Dialog Helpers
    details: Show copyable link dialogs and confirmation prompts without duplicating StaticPopup setup in every addon.
  - title: Launcher Integration
    details: Register LibDataBroker minimap buttons and reuse AddonCompartment handlers with shared tooltip behavior.
---

## What this library provides

Arcane Wizard: Library is a World of Warcraft addon library for shared developer-facing helpers. It is installed as a normal addon and consumed by other addons through the global `ArcaneWizardLibrary` table.

Use this documentation when you want to integrate the library into another addon, wire a settings page, add standard profile/about sections, show shared dialogs, or register launcher entry points.

## Supported clients

The library currently targets Retail, Classic, Burning Crusade Classic Anniversary Edition, and Mists of Pandaria Classic. Supported languages are English, German, and Russian.
