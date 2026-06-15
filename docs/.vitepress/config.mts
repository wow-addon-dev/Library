import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Arcane Wizard: Library',
  description: 'Integration documentation for addon developers using Arcane Wizard: Library.',
  base: '/Library/',
  cleanUrls: true,
  lastUpdated: true,
  themeConfig: {
    logo: '/logo.png',
    siteTitle: 'Arcane Wizard: Library',
    search: {
      provider: 'local'
    },
    nav: [
      { text: 'Guide', link: '/getting-started' },
      { text: 'API', link: '/api/arcane-wizard-library' },
      { text: 'Examples', link: '/examples/basic-addon' },
      { text: 'Releases', link: '/releases' }
    ],
    sidebar: [
      {
        text: 'Start',
        items: [
          { text: 'Overview', link: '/' },
          { text: 'Getting Started', link: '/getting-started' },
          { text: 'Integration', link: '/integration' },
          { text: 'Releases and Compatibility', link: '/releases' }
        ]
      },
      {
        text: 'Guides',
        items: [
          { text: 'Addon Context', link: '/guides/addon-context' },
          { text: 'Dialogs', link: '/guides/dialogs' },
          { text: 'Settings', link: '/guides/settings' },
          { text: 'Minimap Button', link: '/guides/minimap-button' }
        ]
      },
      {
        text: 'API Reference',
        items: [
          { text: 'ArcaneWizardLibrary', link: '/api/arcane-wizard-library' },
          { text: 'Addon Context', link: '/api/addon-context' },
          { text: 'Settings', link: '/api/settings' },
          { text: 'Dialogs', link: '/api/dialogs' },
          { text: 'Utils', link: '/api/utils' }
        ]
      },
      {
        text: 'Examples',
        items: [
          { text: 'Basic Addon', link: '/examples/basic-addon' },
          { text: 'Settings Page', link: '/examples/settings-page' },
          { text: 'Profile Section', link: '/examples/profile-section' }
        ]
      }
    ],
    socialLinks: [
      { icon: 'github', link: 'https://github.com/wow-addon-dev/Library' }
    ],
    footer: {
      message: 'All rights reserved.',
      copyright: 'Copyright (c) 2026 Arcane Wizard'
    }
  }
})
