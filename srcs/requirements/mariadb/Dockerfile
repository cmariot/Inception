# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3

# Update the index of available packages
RUN apk update

# Upgrade the currently installed packages
RUN apk upgrade

# Mariadb istallation
RUN apk add mysql mysql-client

# Installation Directory and File Permissions
RUN mkdir -p /var/lib/mysql
RUN chown -R mysql:mysql /var/lib/mysql /etc/mysql /usr/lib/mariadb /usr/bin

# Add root to the mysql group
RUN addgroup root mysql

# Copy configuration files
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/
COPY ./conf/my.cnf /etc/

# Copy initialization script
COPY ./tools/init_database.sh /

# Expose the mariadb port
EXPOSE 3306

# Launch the script
CMD ["sh", "/init_database.sh"]
