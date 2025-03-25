FROM php:8.2-fpm-alpine

# Install nginx and other dependencies
RUN apk add --no-cache nginx openssl shadow

# Create a non-root user and group with specified IDs
RUN groupadd -g 1000 appuser && \
    useradd -u 1000 -g appuser -s /bin/sh -m appuser

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy PHP files
COPY index.php /usr/share/nginx/html/index.php

# Create necessary directories and set permissions
RUN mkdir -p /var/run/php-fpm && \
    mkdir -p /run/nginx && \
    mkdir -p /var/log/nginx && \
    mkdir -p /var/lib/nginx && \
    mkdir -p /etc/ssl/certs && \
    mkdir -p /etc/ssl/private && \
    chown -R 1000:1000 /var/run/php-fpm && \
    chown -R 1000:1000 /usr/share/nginx/html && \
    chown -R 1000:1000 /var/log/nginx && \
    chown -R 1000:1000 /var/lib/nginx && \
    chown -R 1000:1000 /etc/ssl && \
    chown -R 1000:1000 /run/nginx && \
    chown -R 1000:1000 /etc/nginx

# Switch to non-root user
USER 1000:1000

EXPOSE 80 443

CMD ["/bin/sh", "-c", "openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj '/CN=localhost' && php-fpm -D && nginx -g 'daemon off;'"]