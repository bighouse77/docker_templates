#!/bin/sh
set -e

TARGET_DIR="/vue-app"

if [ ! -f "package.json" ]; then
  echo "Criando projeto Vue em $TARGET_DIR..."

  npm create vite@latest . -- --template vue

  echo "Instalando dependências..."
  npm install

  echo "Ajustando permissões para o usuário $USER_ID:$GROUP_ID..."

  chown -R $USER_ID:$GROUP_ID $TARGET_DIR
else
  echo "Projeto Vue já existe"
fi

echo "Iniciando servidor de desenvolvimento..."

npm run dev -- --host