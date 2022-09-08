# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3

# Update the index of available packages
RUN apk update

# Upgrade the currently installed packages
RUN apk upgrade

RUN apk add mariadb mariadb-client

#RUN mkdir -p /run/mysqld /var/lib/mysql

#RUN chown mysql /var/lib/mysql

EXPOSE 3306

CMD ["ping", "0.0.0.0"]
