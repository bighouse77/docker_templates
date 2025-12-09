#!/bin/sh
set -e

TARGET_DIR="/vue-app"

if [ ! -f "package.json" ]; then
  echo "🚀 Criando projeto Vue em $TARGET_DIR..."

  # Cria projeto Vue com Vite (template vue padrão)
  # O ponto '.' indica para criar no diretório atual
  npm create vite@latest . -- --template vue

  echo "📦 Instalando dependências..."
  npm install

  echo "🔧 Ajustando permissões para o usuário $USER_ID:$GROUP_ID..."
  # Altera o dono dos arquivos para o seu usuário do host
  chown -R $USER_ID:$GROUP_ID $TARGET_DIR
else
  echo "✅ Projeto Vue já existe"
fi

echo "🔥 Iniciando servidor de desenvolvimento..."
# O --host é essencial para o Docker expor a porta para fora
npm run dev -- --host