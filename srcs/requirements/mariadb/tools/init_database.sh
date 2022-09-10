#! /bin/sh

DATABESE=/var/lib/mysql/

if [ ! -z "$(ls -A $DATABESE)" ];
then

	echo "Database isn't empty."

else
	
	echo "Empty"
	mariadb_install_db
	/etc/init.d/mysql start

	echo > install_config
	echo Y >> install_config
	echo pass >> install_config
	echo pass >> install_config
	echo Y >> install_config
	echo n >> install_config
	echo Y >> install_config
	echo Y >> install_config
	mysql_secure_installation < install_config
	rm install_config

	sed "s/#port/port/g" /etc/mysql/mariadb.conf.d/50-server.cnf
	sed "s/127.0.0.1/0.0.0.0/g" /etc/mysql/mariadb.conf.d/50-server.cnf

	mysql -uroot

	echo "CREATE USER 'user'@'localhost' identified by 'pass' ;" > database.create
	echo "CREATE DATABASE IF NOT EXISTS wordpress ;" >> database.create
	echo "GRANT ALL PRIVILEGES ON *.* TO 'user@'%' IDENTIFIED BY 'pass' ;" >> database.create
	echo "FLUSH PRIVILEGES ;" >> database.create
	echo "exit" >> database.create
	
	mysql < database.create
	rm database.create

	service mysql stop

fi

mysqld
