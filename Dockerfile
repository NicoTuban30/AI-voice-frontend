# Use a Node.js version >= 18 as the base image
FROM node:18-alpine

# Create a non-root user with a specific UID
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./ 
RUN npm install --frozen-lockfile

# Check that `next` is installed properly
RUN npm list next

# Ensure `next` is available in the PATH
ENV PATH ./node_modules/.bin:$PATH

# Copy the rest of the application code
COPY . .

# Build the Next.js app
RUN npm run build

# Change ownership of the app directory to the non-root user
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Expose the port the app will run on
EXPOSE 3000

# Start the application in production mode
CMD ["npm", "start"]
