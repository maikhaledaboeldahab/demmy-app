# 1. Get the operating system and Node.js environment
FROM node:24-alpine

# 2. Patch underlying OS vulnerabilities
RUN apk upgrade --no-cache

# 3. Create a folder inside the image for your app
WORKDIR /usr/src/app

# 4. Copy package files
COPY package*.json ./

# 5. Install app dependencies and patch app-level vulnerabilities
RUN npm install --only=production && npm audit fix --force

# 6. Copy application code
COPY . .

# 7. The DevSecOps Master Stroke: Remove npm entirely to eliminate global vulnerabilities
RUN rm -rf /usr/local/lib/node_modules/npm && rm -f /usr/local/bin/npm

# 8. Run as non-root user
USER node

# 9. Start the app directly with Node (since npm is gone)
CMD ["node", "app.js"]