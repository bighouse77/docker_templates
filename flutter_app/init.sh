#!/bin/sh
set -e

TARGET_DIR="/app"

git config --global --add safe.directory $TARGET_DIR

if [ ! -f "pubspec.yaml" ]; then
  echo "Criando projeto Flutter em $TARGET_DIR..."

  flutter create --platforms web .

  echo "Ajustando permissões iniciais..."
  chown -R $USER_ID:$GROUP_ID $TARGET_DIR
else
  echo "Projeto Flutter já existe"
fi

echo "Baixando dependências..."
flutter pub get

chown -R $USER_ID:$GROUP_ID $TARGET_DIR

echo "Iniciando Flutter Web Server na porta 8081..."

flutter run -d web-server --web-port 8081 --web-hostname 0.0.0.0