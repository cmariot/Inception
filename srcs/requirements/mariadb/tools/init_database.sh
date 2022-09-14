#! /bin/sh

DATADIR=/var/lib/mysql

# If the directory is empty
if [ -z "$(ls -A $DATADIR)" ];
then

	# Create a new database
	mysql_install_db --user=mysql --datadir=$DATADIR

	# Launch the server
	mysqld_safe --datadir=$DATADIR & sleep 5

	# Secure database
	cat << EOF | mysql_secure_installation

Y
n
Y
Y
Y
Y
EOF

	# Create a database, a local user and a remote user
	cat << EOF | mariadb
create database $MYSQL_DATABASE;
grant all privileges on $MYSQL_DATABASE.* TO "$MYSQL_USER"@'localhost' identified by "$MYSQL_PASSWORD";
grant all privileges on $MYSQL_DATABASE.* TO "$MYSQL_USER"@'%' identified by "$MYSQL_PASSWORD";
flush privileges;
EOF

	# Kill the database
	pkill mariadb
	pkill mysqld_safe

fi

# Launch the server
mysqld_safe --datadir=$DATADIR
