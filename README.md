# hello-world-nginx-php-self-signed
Nginx container that generates a self-signed cert on start-up and serves Hello world on 80/443, with PHP installed to show all request headers.

# How to use

`docker run -d -p 80:80 -p 443:443 ibz0q/hello-world-nginx-php-self-signed`
