# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3

# Update the index of available packages
RUN apk update

# Upgrade the currently installed packages
RUN apk upgrade

# Install php8 and php8 packages
RUN apk add php php8-fpm php8-mysqli\
	php8-gd php8-curl php8-dom\
	php8-exif php8-fileinfo php8-mbstring\
	php8-zip php8-iconv php8-intl\
	php8-pecl-imagick php8-xml

# Create the www user
RUN adduser -D -g 'www' www

# Create a directory for html files 
RUN mkdir -p /var/www/wordpress
RUN chown -R www:www /var/www/wordpress

# Copy php config files
COPY ./conf/www.conf /etc/php8/php-fpm.d/
COPY ./conf/php.ini /etc/php8/

# Copy the wordpress installation script
COPY ./tools/wordpress_istall.sh /

# Expose the port 9000
EXPOSE 9000

# Install wp and run php
CMD ["sh", "/wordpress_istall.sh"]
