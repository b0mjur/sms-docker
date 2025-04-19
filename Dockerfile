FROM openjdk:17-slim

# Install system dependencies and Node.js 18
RUN apt-get update && apt-get install -y \
    git \
    curl \
    gnupg \
    ca-certificates \
    maven \
 && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
 && apt-get install -y nodejs \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Create app directories
WORKDIR /workspace
RUN mkdir backend frontend

# Clone repos
RUN git clone https://github.com/ArtemOganesyan/smstests.git backend \
 && git clone https://github.com/ArtemOganesyan/coreui-free.git frontend

# Set up frontend
WORKDIR /workspace/frontend
RUN npm install

# Set up backend
WORKDIR /workspace/backend
RUN mvn clean install 

# Copy startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

CMD ["/start.sh"]

