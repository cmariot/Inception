# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3

# Update the index of available packages
RUN apk update

# Upgrade the currently installed packages
RUN apk upgrade

# Mariadb istallation
RUN apk add mariadb mariadb-common mariadb-client

# Mariadb initialisation
#RUN /usr/bin/mariadb setup

# Mariadb configuration

EXPOSE 3306

CMD ["ping", "0.0.0.0"]
