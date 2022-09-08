# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3

# Update the index of available packages
RUN apk update

# Upgrade the currently installed packages
RUN apk upgrade

# Install php-fpm
RUN apk add --no-cache php php8-fpm php8-mysqli

# Update php-fpm config to listen on wordpress:9000
RUN sed -i 's/127.0.0.1/wordpress/g' /etc/php8/php-fpm.d/www.conf

# Copy a wordpress installation script
COPY ./tools/wordpress_install.sh /

# Expose the port 9000 for Nginx
EXPOSE 9000

# Launch php
CMD ["sh", "wordpress_install.sh"]
