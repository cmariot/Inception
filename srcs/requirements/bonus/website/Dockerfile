# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3.16

# Update the index of available packages,
# Upgrade the currently installed packages
RUN apk update && apk upgrade

RUN mkdir -p /var/www/static
COPY ./site/index.html /var/www/static/
RUN wget -O /var/www/static/three.js https://threejs.org/build/three.js

VOLUME /var/www/static

ENTRYPOINT ["sh"]
