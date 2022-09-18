#! /bin/sh

DATADIR=/var/lib/mysql

# This function set the default options to mariadb database
secure_database() {
cat << EOF | mysql_secure_installation

Y
n
Y
Y
Y
Y
EOF
}

# Create the wordpress database
create_database() {
cat << EOF | mariadb
create database $MYSQL_DATABASE;
grant all privileges on $MYSQL_DATABASE.* TO "$MYSQL_USER"@'localhost' identified by "$MYSQL_PASSWORD";
grant all privileges on $MYSQL_DATABASE.* TO "$MYSQL_USER"@'%' identified by "$MYSQL_PASSWORD";
flush privileges;
EOF
}

# Import the default wordress database (with 2 users)
import_wordpress_database() {
	mysql -u root wordpress < /cmariot.42.fr.sql
	rm -f /cmariot.42.fr.sql
}

if [ ! -z "$(ls -A $DATADIR)" ];
then
	rm -f /cmariot.42.fr.sql
	rc-service mariadb start
	rc-service mariadb stop
	echo "The database doen't need to be created."
else
	echo "Database installation ..."
	/etc/init.d/mariadb setup
	rc-service mariadb start
	secure_database
	create_database
	import_wordpress_database
	rc-service mariadb restart
	rc-service mariadb stop
	echo "The database installation is completed."
fi

exec /usr/bin/mysqld --user=mysql --console
