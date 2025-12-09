#!/bin/sh
set -e

# Define o diretório de trabalho
TARGET_DIR="/var/www/html"

if [ ! -f "$TARGET_DIR/artisan" ]; then
  echo "Criando Laravel API..."

  # Cria o projeto (como root inicialmente)
  composer create-project laravel/laravel .

  cp .env.example .env

  # Configurações do Banco SQLite
  touch database/database.sqlite
  # Ajuste no .env para usar SQLite (opcional, mas recomendado para o template rodar liso)
  sed -i 's/DB_CONNECTION=mysql/DB_CONNECTION=sqlite/' .env
  sed -i 's/DB_DATABASE=laravel/DB_DATABASE=\/var\/www\/html\/database\/database.sqlite/' .env
  # Remove configurações extras de DB que podem atrapalhar o sqlite
  sed -i '/DB_HOST/d' .env
  sed -i '/DB_PORT/d' .env
  sed -i '/DB_USERNAME/d' .env
  sed -i '/DB_PASSWORD/d' .env

  php artisan key:generate
  php artisan migrate --graceful

  echo "Ajustando permissões para o usuário $USER_ID:$GROUP_ID..."

  # AQUI ESTÁ A MÁGICA:
  # Altera o dono dos arquivos para o usuário do host
  chown -R $USER_ID:$GROUP_ID $TARGET_DIR

  # Garante permissão de escrita nas pastas de storage e cache
  chmod -R 775 storage bootstrap/cache
else
  echo "Laravel já existe"
fi

# Mantemos o servidor rodando como root no container para não ter erro de permissão interno,
# mas como os arquivos agora são do seu usuário, você consegue editar no VS Code.
php artisan serve --host=0.0.0.0 --port=8000