#!/bin/bash

mkdir -p /etc/ssl/certs /etc/ssl/private

# Set the CN to the value of the environment variable or default to "localhost"
CN=${CERT_CN:-localhost}

if [ "$CN" = "localhost" ]; then
    echo "No CERT_CN specified. Defaulting to CN=localhost." >&1
else
    echo "Using specified CERT_CN: CN=$CN." >&1
fi

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/CN=$CN"

php-fpm -D

nginx -g "daemon off;"