#!/bin/sh
set -e

if [ ! -f package.json ]; then
  echo "🚀 Criando projeto Vue em /app"

  # Cria projeto Vue com Vite
  npm create vite@latest . -- --template vue
  npm install

  chown -R $(id -u):$(id -g) $APP_DIR
  chmod -R u+rw $APP_DIR
else
  echo "✅ Projeto Vue já existe"
fi

# Rodando dev server
npm run dev -- --host
