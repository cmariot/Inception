adduser -D $FTP_USER && cat << EOF | passwd $FTP_USER
$FTP_PASSWORD
$FTP_PASSWORD
EOF

echo $FTP_USER >> /etc/vsftpd/vsftpd_user_conf

mkdir -p /var/www/worpdress &&\
	chown -R $FTP_USER:$FTP_USER /var/www/wordpress

mkdir -p /etc/ssl/certs &&\
	cd /etc/ssl/certs &&\
	openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-keyout vsftpd.key -out vsftpd.pem \
	-subj "/C=FR/ST=Paris/L=Paris/O=42/OU=student/CN=cmariot"
	chmod 600 vsftpd.pem vsftpd.key

exec vsftpd /etc/vsftpd/vsftpd.conf
