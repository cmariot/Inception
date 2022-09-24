# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3.16

# Update the index of available packages,
# Upgrade the currently installed packages
# And install vsftpd (ftp server) and openssl (ssl key generator)
RUN apk update && apk upgrade && apk add --no-cache\
	openssl\
	vsftpd

# Copy the config files
#COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./tools/ftp.sh /

# Launch the ftp script
ENTRYPOINT ["sh"]
CMD ["/ftp.sh"]
