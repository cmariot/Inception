# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3

# Update the index of available packages
RUN apk update

# Upgrade the currently installed packages 
RUN apk upgrade

# Add new packages or upgrade packages to the running system
RUN apk add --no-cache nginx \
						openssl

# Creating new user and group 'www' for nginx
RUN adduser -D -g 'www' www

# Create a directory for html files
RUN mkdir /www
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /www
COPY conf/index.html /www

# Generate a SSL certificate
RUN openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/cmariot.42.fr.pem -keyout /etc/ssl/cmariot.42.fr.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=cmariot/CN=cmariot.42.fr"

# Create a nginx.con backup and copy new config file from volume
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.backup
COPY conf/nginx.conf /etc/nginx

# Set the entrypoint on the port 443
EXPOSE 443

# Run Nginx whenever our Docker image launches
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
