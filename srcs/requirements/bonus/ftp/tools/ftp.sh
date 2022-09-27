#!/bin/sh


# Create a local user allowed to connect on the ftp server
create_ftp_user()
{
	# Create the local FTP user
	adduser -D --system $FTP_USER
	cat << EOF | passwd $FTP_USER
$FTP_PASSWORD
$FTP_PASSWORD
EOF
}


# Give him the ownership of the wordpress directory
change_volume_ownership()
{
	chown -R $FTP_USER /var/www/wordpress
	chmod 755 /var/www/wordpress
}


# Add this user to the ftp allowed user list
allow_connexion()
{
	echo $FTP_USER > /etc/vsftpd.user_list
}


main()
{
	create_ftp_user
	change_volume_ownership
	allow_connexion
}


main
# Launch the ftp server with the pid 1
exec vsftpd /etc/vsftpd/vsftpd.conf
