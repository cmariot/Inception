# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3

# Update the index of available packages
RUN apk update

# Upgrade the currently installed packages
RUN apk upgrade

# Install nginx and openssl
RUN apk add --no-cache nginx openssl

# Creating new user and group 'www' for nginx
RUN adduser -D -g 'www' www

# Create a directory for html files
RUN mkdir /var/www/wordpress/
RUN chown -R www:www /var/lib/nginx
RUN chown -R www:www /var/www/wordpress/

# Generate a SSL certificate
RUN openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/ssl/cmariot.42.fr.pem -keyout /etc/ssl/cmariot.42.fr.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=cmariot/CN=cmariot.42.fr"

# Add the custom nginx configuration file
COPY ./conf/nginx.conf /etc/nginx/http.d/

# Set the entrypoint on the port 443
EXPOSE 443

# Launch the webserver
CMD ["nginx", "-g", "daemon off;"]
