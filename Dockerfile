FROM node:20-slim

WORKDIR /app

# Non-root user
RUN groupadd -r appuser && useradd -r -g appuser appuser

COPY package*.json ./
RUN npm install --production=false && npm cache clean --force

COPY . .

RUN chown -R appuser:appuser /app
USER appuser

# Note: Disabled for container network issues with public APIs
# Not recommended for production services
ENV NODE_TLS_REJECT_UNAUTHORIZED=0

CMD ["npm", "run", "test:report"]
