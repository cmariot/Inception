# syntax=docker/dockerfile:1

# Get the container Image
FROM alpine:3.16

# Update the index of available packages,
# Upgrade the currently installed packages
# And install vsftpd
RUN apk update && apk upgrade && apk add --no-cache\
	openssl\
	vsftpd

COPY ./tools/ftp.sh /
COPY ./conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

ENTRYPOINT ["sh"]
CMD ["/ftp.sh"]
