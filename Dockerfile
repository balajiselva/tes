# 1. Use an official Node image that natively supports both ARM64 and AMD64
FROM node:20-bookworm-slim

# 2. Install Chromium and necessary rendering fonts manually via apt-get
RUN apt-get update && apt-get install -y \
    chromium \
    fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

# 3. Tell Puppeteer to skip downloading the incompatible Chrome binary
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# 4. Point Puppeteer to the natively installed ARM64 Chromium
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies cleanly
RUN npm ci

# Copy the rest of your code
COPY . .

# Expose port
EXPOSE 7000

# Start your addon
CMD ["npm", "start"]
