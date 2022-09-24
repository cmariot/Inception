adduser --system $FTP_USER && cat << EOF | passwd $FTP_USER
$FTP_PASSWORD
$FTP_PASSWORD
EOF

echo $FTP_USER > /etc/vsftpd.user_list

mkdir -p /var/www/wordpress &&\
	chown -R $FTP_USER:$FTP_USER /var/www/wordpress

mkdir -p /etc/ssl/certs &&\
	cd /etc/ssl/certs &&\
	openssl req -x509 -nodes -days 7300 -newkey rsa:2048 -keyout vsftpd.pem -out vsftpd.pem \
	-subj "/C=FR/ST=Paris/L=Paris/O=42/OU=student/CN=cmariot" &&\
	chmod 600 vsftpd.pem

exec vsftpd /etc/vsftpd/vsftpd.conf
