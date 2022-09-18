# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3

# Update the index of available packages
RUN apk update

# Upgrade the currently installed packages
RUN apk upgrade

# Mariadb istallation
RUN apk add mariadb mariadb-client mariadb-common openrc

# Launch openrc for rc-service
RUN openrc
RUN touch /run/openrc/softlevel

# Copy initialization script
COPY ./tools/init_database.sh /
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/
COPY ./conf/my.cnf /etc/
COPY ./conf/cmariot.42.fr.sql /

# Expose the mariadb port
EXPOSE 3306

# Launch the script
CMD ["sh", "/init_database.sh"]
