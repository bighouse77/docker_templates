FROM node:20

WORKDIR /var/www/html

COPY init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

ENTRYPOINT ["/usr/local/bin/init.sh"]