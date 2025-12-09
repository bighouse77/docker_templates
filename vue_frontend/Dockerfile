FROM node:20

WORKDIR /app

# Copia script de inicialização
COPY init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

CMD ["init.sh"]
