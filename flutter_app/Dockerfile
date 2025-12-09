FROM cirrusci/flutter:latest

WORKDIR /app
COPY . .

# Instala dependências
RUN flutter pub get

# Build para web (ou mobile você roda direto no emulator/device)
CMD ["flutter", "run", "-d", "web-server", "--web-port", "8081", "--web-hostname", "0.0.0.0"]
