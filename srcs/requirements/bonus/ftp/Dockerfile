# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3.16

# Update the index of available packages,
# Upgrade the currently installed packages
# And install vsftpd (ftp server) and openssl (ssl key generator)
RUN apk update && apk upgrade && apk add --no-cache\
	openssl\
	vsftpd

# Generate an auto signed ssl certificate
RUN mkdir -p /etc/ssl/certs &&\
	cd /etc/ssl/certs &&\
	openssl req -x509 -nodes -days 7300 -newkey rsa:2048\
		-keyout vsftpd.pem\
		-out vsftpd.pem\
		-subj "/C=FR/ST=Paris/L=Paris/O=42/OU=student/CN=cmariot" &&\
	chmod 600 vsftpd.pem

# Create a directory for the volume
RUN mkdir -p /var/www/wordpress
VOLUME /var/www/wordpress

# Copy the config files
COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY ./tools/ftp.sh /

# Launch the ftp script
ENTRYPOINT ["sh"]
CMD ["/ftp.sh"]
