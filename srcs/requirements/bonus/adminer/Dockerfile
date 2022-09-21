# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3.16

# Update the index of available packages,
# Upgrade the currently installed packages
RUN apk update && apk upgrade

# Copy the config file
COPY ./tools/adminer_install.sh /

# Launch the redis server
ENTRYPOINT ["sh"]
CMD ["/adminer_install.sh"]
