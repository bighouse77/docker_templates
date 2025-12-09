FROM node:20 AS node
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM php:8.2-fpm
WORKDIR /var/www/html

# PHP extensions
RUN apt-get update && apt-get install -y libzip-dev zip \
    && docker-php-ext-install pdo_mysql zip

# Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY . .
COPY --from=node /app/dist ./public

RUN composer install --no-dev --optimize-autoloader
RUN chown -R www-data:www-data storage bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
