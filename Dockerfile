FROM python:3.11-slim-buster

# Install Chrome and ChromeDriver
RUN apt-get update && apt-get install -y curl gnupg
RUN curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update && apt-get install -y google-chrome-stable

# Set Chrome binary location (optional, but good practice)
ENV CHROME_BIN=/usr/bin/google-chrome-stable
ENV TELEGRAM_CHAT_ID=1012523562
ENV TELEGRAM_BOT_TOKEN=7374238596:AAFYpFCAxUWHmGmGFVhJBhseC3ByEyYIX2A

# Install ChromeDriver (webdriver-manager will handle this, but ensure compatibility)
# We will rely on webdriver-manager to get the correct chromedriver, so no manual install here

# Set working directory
WORKDIR /app

# Copy requirements and install Python dependencies
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

# Copy the application code
COPY . .

# Set the command to run your script
CMD ["python", "scrape_promodescuentos.py"]