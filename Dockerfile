# Add the --platform flag to ensure compatibility
FROM --platform=linux/amd64 ghcr.io/puppeteer/puppeteer:24.0.0

# Create app directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
# Using 'ci' is often better for Docker to ensure clean, reproducible installs
RUN npm ci

# Copy the rest of your code
COPY . .

# Expose port
EXPOSE 7000

# Start your addon
CMD ["npm", "start"]
