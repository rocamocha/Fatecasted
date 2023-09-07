const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');

(async () => {
  const inputDir = path.resolve(__dirname, 'cards/test');
  const outputDir = path.resolve(__dirname, 'cards/exported');

  // Make sure output directory exists
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }

  // Get all .html files in inputDir
  const files = fs.readdirSync(inputDir).filter(f => f.endsWith('.html'));

  if (files.length === 0) {
    console.log('No HTML files found in', inputDir);
    process.exit(0);
  }

  const browser = await puppeteer.launch({
  headless: true,
  defaultViewport: {
    width: 264,
    height: 453,
    deviceScaleFactor: 4,  // <-- add this line
    },
  });

  const page = await browser.newPage();

  for (const file of files) {
    const filePath = path.join(inputDir, file);
    const fileUrl = 'file://' + filePath;

    const outputFileName = path.basename(file, '.html') + '.png';
    const outputPath = path.join(outputDir, outputFileName);

    console.log(`Rendering ${fileUrl} -> ${outputPath}`);

    await page.goto(fileUrl, { waitUntil: 'networkidle0' });

    // Optional: Wait a bit more if your page has animations or delayed rendering
    // await page.waitForTimeout(1000);

    await page.screenshot({ path: outputPath });

    console.log(`✅ Screenshot saved: ${outputPath}`);
  }

  await browser.close();
})();
