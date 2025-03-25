FROM php:8.2-fpm-alpine

# Install nginx and other dependencies
RUN apk add --no-cache nginx openssl

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy PHP files
COPY index.php /usr/share/nginx/html/index.php

# Create necessary directories and set permissions
RUN mkdir -p /var/run/php-fpm && \
    mkdir -p /run/nginx && \
    mkdir -p /var/log/nginx && \
    mkdir -p /var/lib/nginx && \
    chown -R www-data:www-data /var/run/php-fpm && \
    chown -R www-data:www-data /usr/share/nginx/html && \
    chown -R www-data:www-data /var/log/nginx && \
    chown -R www-data:www-data /var/lib/nginx && \
    chown -R www-data:www-data /etc/ssl && \
    chown -R www-data:www-data /run/nginx && \
    chown -R www-data:www-data /etc/nginx

# Switch to non-root user
USER www-data

EXPOSE 80 443

CMD ["/bin/sh", "-c", "mkdir -p /etc/ssl/certs /etc/ssl/private && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj '/CN=localhost' && php-fpm -D && nginx -g 'daemon off;'"]