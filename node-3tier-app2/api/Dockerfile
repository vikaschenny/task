FROM node
# Install Node.js and npm
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install net-tools vim -y \
    && apt-get install -y nodejs npm \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a directory for the application
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to WORKDIR
COPY package*.json ./

# Install dependencies
RUN npm install
RUN npm update pg-protocol
RUN npm audit fix --force

# Copy the rest of the application
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
CMD ["npm", "start"]
