import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'Arcane Wizard: Library',
  description: 'Documentation for addon developers using Arcane Wizard: Library.',
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
      { text: 'Overview', link: '/' },
      { text: 'API', link: '/api/arcane-wizard-library' },
      { text: 'Examples', link: '/examples/basic-addon' },
      { text: 'Changelogs', link: '/changelogs' }
    ],
    sidebar: [
      {
        text: 'Start',
        items: [
          { text: 'Overview', link: '/' },
          { text: 'Changelogs', link: '/changelogs' }
        ]
      },
      {
        text: 'API Reference',
        items: [
          { text: 'ArcaneWizardLibrary', link: '/api/arcane-wizard-library' },
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
