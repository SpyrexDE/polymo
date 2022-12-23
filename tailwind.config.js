/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
      './config/initializers/heroicon.rb'
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography'),
  ]
}
