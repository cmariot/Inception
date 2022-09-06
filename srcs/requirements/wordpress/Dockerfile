# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3

# Update the index of available packages
RUN apk update

# Upgrade the currently installed packages
RUN apk upgrade

RUN apk add php-fpm

EXPOSE 9000

# Update php-fpm config to listen on wordpress:9000
RUN sed -i 's/127.0.0.1/wordpress/g' /etc/php8/php-fpm.d/www.conf

CMD ["php-fpm8", "-F", "-R"]
