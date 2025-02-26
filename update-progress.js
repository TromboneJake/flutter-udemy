const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch({
    args: ['--no-sandbox', '--disable-setuid-sandbox', '--disable-dev-shm-usage'],
    headless: true
  });
  const page = await browser.newPage();

  const email = process.env.UDEMY_EMAIL;
  const password = process.env.UDEMY_PASSWORD;

  console.log('Navigating to Udemy homepage...');
  await page.goto('https://www.udemy.com', { waitUntil: 'networkidle2' });

  // Log current URL to verify where we are
  console.log('Current URL:', await page.url());

  // Try clicking login link if on homepage
  try {
    console.log('Looking for login link...');
    await page.waitForSelector('a[data-purpose="header-login"]', { timeout: 5000 });
    await page.click('a[data-purpose="header-login"]');
    await page.waitForNavigation({ waitUntil: 'networkidle2' });
    console.log('Clicked login link, new URL:', await page.url());
  } catch (e) {
    console.log('Login link not found or already on login page:', e.message);
  }

  // Wait for email field with longer timeout and log page content if it fails
  console.log('Waiting for email input...');
  try {
    await page.waitForSelector('input[name="email"]', { timeout: 20000 }); // 20s timeout
    console.log('Email input found!');
    await page.type('input[name="email"]', email);
    await page.type('input[name="password"]', password);
    await page.click('input[type="submit"]');
    await page.waitForNavigation({ waitUntil: 'networkidle2' });
    console.log('Logged in, URL:', await page.url());
  } catch (e) {
    console.log('Error finding email input:', e.message);
    console.log('Page content:', await page.content()); // Log HTML for debugging
    await browser.close();
    process.exit(1); // Exit with error
  }

  // Go to enrolled courses page
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
