#! /bin/sh

/etc/init.d/mariadb setup
rc-service mariadb start

cat << EOF | mysql_secure_installation

Y
n
Y
Y
Y
Y
EOF

cat << EOF | mariadb
create database $MYSQL_DATABASE;
grant all privileges on $MYSQL_DATABASE.* TO "$MYSQL_USER"@'localhost' identified by "$MYSQL_PASSWORD";
grant all privileges on $MYSQL_DATABASE.* TO "$MYSQL_USER"@'%' identified by "$MYSQL_PASSWORD";
flush privileges;
EOF

rc-service mariadb restart
rc-service mariadb stop

exec /usr/bin/mysqld --user=mysql --console
