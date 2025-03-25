FROM php:8.2-fpm-alpine

RUN apk add --no-cache nginx openssl

COPY nginx.conf /etc/nginx/nginx.conf

COPY index.php /usr/share/nginx/html/index.php

RUN mkdir -p /var/run/php-fpm

EXPOSE 80 443

CMD ["/bin/sh", "-c", "mkdir -p /etc/ssl/certs /etc/ssl/private && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj '/CN=localhost' && php-fpm -D && nginx -g 'daemon off;'"]