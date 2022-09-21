# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3.16

# Update the index of available packages,
# Upgrade the currently installed packages
# And install redis
RUN apk update && apk upgrade && apk add --no-cache\
	vsftpd

# Launch the redis server
ENTRYPOINT ["ping"]
CMD ["0.0.0.0"]
