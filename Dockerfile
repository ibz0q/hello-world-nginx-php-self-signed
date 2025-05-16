FROM php:8.2-fpm-alpine

RUN apk add --no-cache nginx openssl bash

COPY nginx.conf /etc/nginx/nginx.conf

COPY index.php /usr/share/nginx/html/index.php

RUN mkdir -p /var/run/php-fpm

EXPOSE 80 443

ENTRYPOINT ["bash", "/entrypoint.sh"]