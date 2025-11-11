# Use the official Node.js LTS image
FROM node:18-alpine

# Set working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and ecosystem config first (for layer caching)
COPY package*.json ecosystem.config.js ./

# Install PM2 globally and app dependencies
RUN npm install -g pm2 && npm install --only=production

# Copy the rest of the app (like app.js)
COPY . .

# Expose the app port
EXPOSE 3000

# Start the app using PM2 and ecosystem config
CMD ["pm2-runtime", "start", "ecosystem.config.js"]
