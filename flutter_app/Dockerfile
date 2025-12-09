FROM cirrusci/flutter:latest

WORKDIR /app
COPY . .

# Só roda flutter pub get se pubspec.yaml existir
RUN if [ -f pubspec.yaml ]; then \
        flutter pub get; \
    else \
        echo "pubspec.yaml not found, skipping flutter pub get"; \
    fi

EXPOSE 8081
CMD ["flutter", "run", "-d", "web-server", "--web-port", "8081", "--web-hostname", "0.0.0.0"]
