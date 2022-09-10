# syntax=docker/dockerfile:1

# Get the container Image
FROM debian:buster

# Update the index of available packages
RUN apt-get update

# Upgrade the currently installed packages
RUN apt-get upgrade

# Mariadb istallation
RUN apt-get install mariadb-client mariadb-server -y

# Open the mariadb port
EXPOSE 3306

# Copy database installation script
COPY ./tools/init_database.sh /usr/bin

# Launch the script
CMD ["ping", "0.0.0.0"]
#CMD ["sh", "/usr/bin/init_database.sh"]
