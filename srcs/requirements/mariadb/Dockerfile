# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3.16

# Update the index of available packages
# Upgrade the currently installed packages
# Install tools required for Mariadb
RUN apk update && apk upgrade && apk add --no-cache\
	mariadb\
	mariadb-client\
	mariadb-common\
	openrc

# Launch openrc for rc-service
RUN openrc\
	&& touch /run/openrc/softlevel

# Copy initialization script
COPY ./conf/mariadb-server.cnf	/etc/my.cnf.d/
COPY ./conf/my.cnf				/etc/
COPY ./tools/init_database.sh	/

# Expose the mariadb port
EXPOSE 3306

# Launch the script
CMD ["sh", "/init_database.sh"]
