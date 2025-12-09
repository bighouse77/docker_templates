#!/bin/sh

if [ ! -f pubspec.yaml ]; then
  echo "Criando Flutter App"
  flutter create .
fi

chown -R $(id -u):$(id -g) $APP_DIR
chmod -R u+rw $APP_DIR

flutter pub get
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8080
