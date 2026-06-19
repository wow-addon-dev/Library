// @ts-ignore
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
      { text: 'Changelog', link: '/changelog' }
    ],
    sidebar: [
      {
        text: 'Start',
        items: [
          { text: 'Overview', link: '/' },
          { text: 'Changelog', link: '/changelog' }
        ]
      },
      {
        text: 'API Reference',
        items: [
          { text: 'Addon API', link: '/api/arcane-wizard-library' },
          { text: 'Settings Static API', link: '/api/settings' },
          { text: 'Dialogs Static API', link: '/api/dialogs' },
          { text: 'Utils Static API', link: '/api/utils' }
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
      message: 'Released under the MIT License.',
      copyright: 'Copyright (c) 2026 Arcane Wizard'
    }
  }
})
