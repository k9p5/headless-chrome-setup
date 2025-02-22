import puppeteer from 'puppeteer';

async function checkGPU() {
  const browser = await puppeteer.launch({
    args: [
      '--no-sandbox',
      '--use-angle=vulkan',
      '--enable-features=Vulkan',
      '--disable-vulkan-surface',
      '--enable-unsafe-webgpu'
    ]
  });

  try {
    const page = await browser.newPage();

    await page.goto('chrome://gpu');

    const txt = await page.waitForSelector('text/Graphics Feature Status');
    const status = await txt.evaluate(g => g.parentElement.parentElement.textContent);
    console.log(status.replace(/\s+/g, ' ').replace(/\*/g, '\n').trim());

  } catch (error) {
    console.error('Error:', error);
  } finally {
    await browser.close();
  }
}

checkGPU(); 