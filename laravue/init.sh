#!/bin/sh
set -e

TARGET_DIR="/var/www/html"

if [ ! -f "$TARGET_DIR/artisan" ]; then
  echo "🚀 Criando Laravue Monolito..."

  composer create-project laravel/laravel .

  cp .env.example .env

  touch database/database.sqlite
  sed -i 's/DB_CONNECTION=mysql/DB_CONNECTION=sqlite/' .env
  sed -i 's/DB_DATABASE=laravel/DB_DATABASE=\/var\/www\/html\/database\/database.sqlite/' .env

  sed -i '/DB_HOST/d' .env
  sed -i '/DB_PORT/d' .env
  sed -i '/DB_USERNAME/d' .env
  sed -i '/DB_PASSWORD/d' .env

  php artisan key:generate
  php artisan migrate --graceful

  echo "📦 Instalando Vue e dependências..."
  npm install
  npm install vue @vitejs/plugin-vue

  npm install -D @vitejs/plugin-vue

  echo "🔧 Ajustando permissões para o usuário $USER_ID:$GROUP_ID..."
  chown -R $USER_ID:$GROUP_ID $TARGET_DIR
  chmod -R 775 storage bootstrap/cache
else
  echo "✅ Laravue já existe"
fi

php artisan serve --host=0.0.0.0 --port=8000 &

echo "🔥 Iniciando Vite..."
npm run dev -- --host