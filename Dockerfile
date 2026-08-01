# 1. Get the operating system and Node.js environment
FROM node:24-alpine

RUN apk upgrade --no-cache
RUN npm install -g npm@latest
# 2. Create a folder inside the image for your app
WORKDIR /usr/src/app

# 3. Copy your package.json into the image
COPY package*.json ./

# 4. Install the dependencies inside the image
RUN npm install --only=production && npm audit fix --force

# 5. Copy the rest of your app's code into the image
COPY . .

# 6. Switch to a non-root user for security
USER node

# Tell the container what to execute when it wakes up
CMD ["npm", "start"]