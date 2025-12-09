FROM node:20

WORKDIR /app

COPY package*.json ./

RUN if [ -f package.json ]; then \
        npm install; \
    else \
        echo "package.json not found, skipping npm install"; \
    fi

COPY . .

EXPOSE 8080
CMD ["npm", "run", "serve"]
