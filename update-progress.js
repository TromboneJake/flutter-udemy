const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({
    args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage'],
    headless: true
  });
  const page = await browser.newPage();

  const udemyEmail = process.env.UDEMY_EMAIL;
  const googleEmail = process.env.GOOGLE_EMAIL; // Add this to GitHub Secrets
  const googlePassword = process.env.GOOGLE_PASSWORD; // Add this to GitHub Secrets

  console.log('Navigating directly to login popup...');
  await page.goto('https://www.udemy.com/join/login-popup/?locale=en_US', { waitUntil: 'networkidle2' });
  console.log('Current URL:', await page.url());

  console.log('Looking for Google login button...');
  try {
    // Adjust selector based on Udemy's Google login button (inspect it)
    await page.waitForSelector('button[aria-label="Continue with Google ID"]');
    await page.click('button[aria-label="Continue with Google ID"]');
    console.log('Clicked Google login button');
  } catch (e) {
    console.log('Google login button not found:', e.message);
    console.log('Page content:', await page.content());
    await browser.close();
    process.exit(1);
  }

  // Wait for Google popup and switch to it
  const [popup] = await Promise.all([
    new Promise(resolve => browser.once('targetcreated', target => resolve(target.page()))),
    page.waitForTimeout(2000) // Give popup time to appear
  ]);

  if (!popup) {
    console.log('Google popup not detected');
    await browser.close();
    process.exit(1);
  }

  console.log('Switched to Google popup');
  await popup.waitForSelector('input[type="email"]', { timeout: 30000 });
  await popup.type('input[type="email"]', googleEmail);
  await popup.click('#identifierNext'); // Next button
  await popup.waitForTimeout(2000); // Wait for password field

  await popup.waitForSelector('input[type="password"]', { timeout: 30000 });
  await popup.type('input[type="password"]', googlePassword);
  await popup.click('#passwordNext'); // Next button
  await popup.waitForNavigation({ waitUntil: 'networkidle2' });

  console.log('Google login completed, closing popup...');
  await popup.close();

  // Switch back to main page and wait for Udemy to finish login
  await page.bringToFront();
  await page.waitForNavigation({ waitUntil: 'networkidle2' });
  console.log('Logged in, URL:', await page.url());

  console.log('Navigating to courses page...');
  await page.goto('https://www.udemy.com/home/my-courses/learning/', { waitUntil: 'networkidle2' });

  const progress = await page.evaluate(() => {
    const anchors = document.querySelectorAll('a');
    let targetProgress = '0%';
    for (const anchor of anchors) {
      if (anchor.textContent.includes('Flutter & Dart')) {
        const parent = anchor.parentElement;
        if (parent) {
          const progressDiv = parent.querySelector('.enrolled-course-card--progress-and-rating--z0u5V');
          if (progressDiv) {
            const progressElement = progressDiv.querySelector('.progress-bar__progress');
            if (progressElement && progressElement.style.width) {
              targetProgress = progressElement.style.width;
            } else {
              const progressText = progressDiv.textContent.match(/(\d+)%/);
              if (progressText) {
                targetProgress = progressText[1] + '%';
              }
            }
          }
        }
        break;
      }
    }
    return targetProgress;
  });

  console.log(`Progress for Flutter & Dart: ${progress}`);
  await browser.close();

  const progressNumber = progress.replace('%', '');
  require('fs').writeFileSync('progress.txt', progressNumber);
})();
