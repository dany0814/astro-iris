import { defineConfig } from 'windicss/helpers';

export default defineConfig({
  darkMode: false, // or 'media' or 'class'
  corePlugins: {
    container: false,
  },
  theme: {
    extend: {
      colors: {
        'dark': '#121139',
        'light': '#ffffff'
      },
    },
  },
  extract: {
    include: ['./src/**/*.{vue,html,jsx,tsx,astro}'],
    exclude: ['node_modules', '.git'],
  },
  plugins: [require('windicss/plugin/typography')],
});