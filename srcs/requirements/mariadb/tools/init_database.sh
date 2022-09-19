#! /bin/sh


DATADIR=/var/lib/mysql


# This function set the default options to mariadb database
secure_database()
{
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
create_database()
{
	cat << EOF | mariadb -u root
CREATE DATABASE $MYSQL_DATABASE;
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO "$MYSQL_USER"@"localhost" IDENTIFIED BY "$MYSQL_PASSWORD";
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO "$MYSQL_USER"@"%" IDENTIFIED BY "$MYSQL_PASSWORD";
FLUSH PRIVILEGES;
EOF
}

# Import the default wordress database (with 2 users)
import_wordpress_database()
{
	mariadb -u root wordpress < /cmariot.42.fr.sql
	rm -f /cmariot.42.fr.sql
}


main()
{
	if [ ! -z "$(ls -A $DATADIR)" ];
	then
		echo "The database doesn't need to be created."
		rm -f /cmariot.42.fr.sql
		rc-service mariadb start
		rc-service mariadb stop
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
}


main
exec /usr/bin/mysqld --user=mysql --console
