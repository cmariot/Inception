# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3

# Update the index of available packages
RUN apk update

# Upgrade the currently installed packages
RUN apk upgrade

# Check for package names that match mariadb
RUN apk search mariadb

# Install MariaDB 10.6 on Alpine Linux
RUN apk add --no-cache mariadb mariadb-common mariadb-client
