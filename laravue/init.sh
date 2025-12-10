#!/bin/sh
set -e

echo "Projeto em: $(pwd)"

if [ ! -f artisan ]; then
  echo "🚀 Criando Laravue Monolito"

  composer create-project laravel/laravel .

  cp .env.example .env

  touch database/database.sqlite

  sed -i 's/DB_CONNECTION=.*/DB_CONNECTION=sqlite/' .env
  sed -i 's|DB_DATABASE=.*|DB_DATABASE=/var/www/html/database/database.sqlite|' .env

  sed -i '/DB_HOST/d;/DB_PORT/d;/DB_USERNAME/d;/DB_PASSWORD/d' .env

  php artisan key:generate
  php artisan migrate --graceful

  echo "Instalando dependências frontend"
  npm install
  npm install vue @vitejs/plugin-vue

  echo "Ajustando permissões"
  chown -R ${USER_ID}:${GROUP_ID} .
  chmod -R 775 storage bootstrap/cache
else
  echo "Laravue já existe"
fi

php artisan serve --host=0.0.0.0 --port=8000 &

npm run dev -- --host
