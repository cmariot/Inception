# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3

# Update the index of available packages
RUN apk update

# Upgrade the currently installed packages 
RUN apk upgrade

# Add new packages or upgrade packages to the running system
RUN apk add --no-cache nginx

# Set the entrypoint on the port 443
EXPOSE 443

# Run Nginx whenever our Docker image launches
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
