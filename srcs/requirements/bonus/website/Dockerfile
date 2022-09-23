# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3.16

# Update the index of available packages,
# Upgrade the currently installed packages
RUN apk update && apk upgrade

COPY ./site /var/www/wordpress/wp-content/themes/static_website

ENTRYPOINT ["sh"]
