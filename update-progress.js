const puppeteer = require('puppeteer');

(async () => {
  // Launch Puppeteer with --no-sandbox
  const browser = await puppeteer.launch({
    args: ['--no-sandbox', '--disable-setuid-sandbox',  '--disable-dev-shm-usage'],
    headless: true // Ensure headless mode (default, but explicit here)
  });
  const page = await browser.newPage();

  // Use environment variables from GitHub Secrets
  const email = process.env.UDEMY_EMAIL;
  const password = process.env.UDEMY_PASSWORD;

  // Log in to Udemy
  await page.goto('https://www.udemy.com');
  await page.type('input[name="email"]', email);
  await page.type('input[name="password"]', password);
  await page.click('#submit-id-submit');
  await page.waitForNavigation();

  // Go to your enrolled courses page
  await page.goto('https://www.udemy.com/home/my-courses/learning/');

  // Find the course and extract progress
  const progress = await page.evaluate(() => {
    // Find all anchor elements
    const anchors = document.querySelectorAll('a');
    let targetProgress = '0%'; // Default if not found

    for (const anchor of anchors) {
      // Check if the anchor text contains "Flutter & Dart"
      if (anchor.textContent.includes('Flutter & Dart')) {
        // Get the parent of the anchor
        const parent = anchor.parentElement;
        if (parent) {
          // Find the progress div within the parent
          const progressDiv = parent.querySelector('.enrolled-course-card--progress-and-rating--z0u5V');
          if (progressDiv) {
            // Look for a progress bar or text within the div (adjust selector as needed)
            const progressElement = progressDiv.querySelector('.progress-bar__progress');
            if (progressElement && progressElement.style.width) {
              targetProgress = progressElement.style.width; // e.g., "75%"
            } else {
              // Alternative: Look for text content if progress is not in a bar
              const progressText = progressDiv.textContent.match(/(\d+)%/);
              if (progressText) {
                targetProgress = progressText[1] + '%'; // e.g., "75%"
              }
            }
          }
        }
        break; // Stop after finding the course
      }
    }

    return targetProgress;
  });

  console.log(`Progress for Flutter & Dart: ${progress}`);
  await browser.close();

  // Output just the number for the GitHub Action
  const progressNumber = progress.replace('%', '');
  require('fs').writeFileSync('progress.txt', progressNumber);
})();
