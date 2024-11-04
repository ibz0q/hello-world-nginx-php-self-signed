#!/bin/bash

# Create directories for SSL certificates if they don't exist
mkdir -p /etc/ssl/certs /etc/ssl/private

# Generate a self-signed SSL certificate
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/CN=localhost"

# Start Nginx
nginx -g "daemon off;"
