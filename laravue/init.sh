#!/bin/sh
set -e

if [ ! -f artisan ]; then
  echo "🚀 Criando Laravue monolito em /app"

  # Laravel
  composer create-project laravel/laravel .

  cp .env.example .env
  php artisan key:generate

  # Vue
  npm create vite@latest . -- --template vue
  npm install

  # Banco
  touch database/database.sqlite
  php artisan migrate --graceful

  chown -R $(id -u):$(id -g) $APP_DIR
  chmod -R u+rw $APP_DIR
else
  echo "✅ Laravue já existe"
fi

# Rodando Laravel + Vite dev server
php artisan serve --host=0.0.0.0 --port=8000 &
npm run dev -- --host
wait
