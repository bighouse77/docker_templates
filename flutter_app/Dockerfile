FROM ghcr.io/cirruslabs/flutter:stable

WORKDIR /app

USER root

COPY init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

ENTRYPOINT ["/usr/local/bin/init.sh"]