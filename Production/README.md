# Production Tooling

This directory contains the production tooling for generating card images for the Fatecasted card game. It provides scripts to convert card data from TSV (Tab-Separated Values) spreadsheets into HTML representations and then render them as high-resolution PNG images using browser automation.

## Prerequisites

- **Node.js** (for running the build script)
- **Lua** (for generating HTML from data)
- **Puppeteer** (installed via `npm install` from `package.json`)

## Usage

1. **Generate HTML Cards**: Run the Lua script to process TSV data and create HTML files.
   ```
   lua main.lua
   ```
   - Follow the prompts to select card type (Character or Fate) and set number.
   - HTML files will be generated in `cards/test/` (or `cards/markup/` if PRODUCTION is set to true in `main.lua`).

2. **Render to Images**: Use the Node.js script to convert HTML files to PNG images.
   ```
   node build.js
   ```
   - This uses Puppeteer to take screenshots of the HTML files.
   - Output PNGs are saved in `cards/exported/`.

## File Structure

- `build.js`: Node.js script for rendering HTML to PNG using Puppeteer.
- `main.lua`: Lua script for generating HTML from TSV data.
- `def.lua`: Lua configuration for package paths.
- `sheets/`: Directory containing TSV files with card data.
- `cards/`: Directory for generated HTML and exported images.
- `modules/`: Lua modules and dependencies.
- `fonts/`: Font files used in card styling.
- `css/`: Stylesheets for character and fate cards.