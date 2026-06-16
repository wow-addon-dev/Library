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
      text: API Reference
      link: /api/arcane-wizard-library
    - theme: alt
      text: Examples
      link: /examples/basic-addon

features:
  - title: Addon API
    details: Create an addon context with ArcaneWizardLibrary:NewAddon and use context methods for metadata, media paths, chat output, and launcher helpers.
    link: /api/arcane-wizard-library
    linkText: Open API
  - title: Settings Static API
    details: Call ArcaneWizardLibrary.Settings directly to build Blizzard settings pages with buttons, info rows, controls, sections, and about rows.
    link: /api/settings
    linkText: Open API
  - title: Dialogs Static API
    details: Call ArcaneWizardLibrary.Dialogs directly to show reusable link-copy and confirmation dialogs.
    link: /api/dialogs
    linkText: Open API
  - title: Utils Static API
    details: Call ArcaneWizardLibrary.Utils directly for deep table copies and current character or realm keys.
    link: /api/utils
    linkText: Open API
---

<script setup lang="ts">
import { computed } from 'vue'
import { useData } from 'vitepress'

const { page } = useData()

const formattedLastUpdated = computed(() => {
  const timestamp = page.value.lastUpdated

  return timestamp
    ? new Intl.DateTimeFormat('en-US', { dateStyle: 'medium' }).format(new Date(timestamp))
    : ''
})

const machineLastUpdated = computed(() => {
  const timestamp = page.value.lastUpdated

  return timestamp ? new Date(timestamp).toISOString() : ''
})
</script>

## Who this documentation is for

This documentation is for World of Warcraft addon developers who want to use Arcane Wizard: Library as a dependency in their own addon.

The library is installed as a normal addon and consumed through the global `ArcaneWizardLibrary` table. Your addon declares the dependency and creates an addon context for addon-specific behavior. `Settings`, `Dialogs`, and `Utils` are static namespaces that are called directly.

## What you can build with it

Use the API reference and examples when you want to:

- create an addon context for metadata, asset paths, chat output, and debug output,
- build Blizzard settings pages with less repeated UI code,
- add standard profile and about sections,
- show confirmation or copy-link dialogs,
- use utility helpers for tables and character keys.

## Using the library

Add Arcane Wizard: Library as a dependency in your addon's `.toc` file:

```text
## Dependencies: ArcaneWizardLibrary
```

Your addon can then use the global `ArcaneWizardLibrary` table during startup:

```lua
local addonName = ...

local addon = ArcaneWizardLibrary:NewAddon(addonName, {
  debugEnabled = false
})
```

For complete function details, use the API reference. For copy-pasteable addon snippets, use the examples.

## Supported clients and languages

The library currently supports the following clients and languages.

Supported clients:

- Retail
- Classic
- Burning Crusade - Classic Anniversary Edition
- Mists of Pandaria - Classic

Supported languages:

- English (`enUS`)
- German (`deDE`)
- Russian (`ruRU`)

<p v-if="formattedLastUpdated" class="home-last-updated">
  Last updated: <time :datetime="machineLastUpdated">{{ formattedLastUpdated }}</time>
</p>
