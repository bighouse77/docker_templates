# Build do Vue
FROM node:20 AS node
WORKDIR /app
COPY package*.json ./
RUN if [ -f package.json ]; then npm install; else echo "package.json not found, skipping npm install"; fi
COPY . .
RUN if [ -f package.json ]; then npm run build; else echo "Skipping Vue build"; fi

# Build do Laravel
FROM php:8.2-fpm
WORKDIR /var/www/html

RUN apt-get update && apt-get install -y libzip-dev zip libpq-dev \
    && docker-php-ext-install pdo_mysql pdo_pgsql

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
COPY . .
COPY --from=node /app/dist ./public

RUN if [ -f composer.json ]; then \
        composer install --no-dev --optimize-autoloader; \
    else \
        echo "composer.json not found, skipping composer install"; \
    fi

RUN mkdir -p storage bootstrap/cache \
    && chown -R www-data:www-data storage bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
