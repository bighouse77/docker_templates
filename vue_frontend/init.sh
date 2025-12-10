#!/bin/sh
set -e

echo "Projeto Vue em: $(pwd)"

if [ ! -f package.json ]; then
  echo "Criando projeto Vue..."

  npm create vite@latest . -- --template vue

  echo "Instalando dependências..."
  npm install

  echo "Ajustando permissões..."
  chown -R ${USER_ID}:${GROUP_ID} .
else
  echo "Projeto Vue já existe"
fi

echo "▶Iniciando servidor Vite..."
npm run dev -- --host