FROM node:18

# Set working directory
WORKDIR /app

# Ensure correct permissions
RUN chown -R node:node /app

# Switch to non-root user
USER node

# Copy package.json and yarn.lock first (for caching dependencies)
COPY --chown=node:node package.json yarn.lock ./

# Install dependencies
RUN yarn install --frozen-lockfile

# Copy the rest of the application files
COPY --chown=node:node . .

# Build the application
RUN yarn build

# Expose the port the app will run on
EXPOSE 3000

# Start the application in producti
CMD ["yarn", "start"]
