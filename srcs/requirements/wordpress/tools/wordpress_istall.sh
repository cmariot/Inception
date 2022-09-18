# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    wordpress_istall.sh                                :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmariot <cmariot@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/07 14:15:26 by cmariot           #+#    #+#              #
#    Updated: 2022/09/18 16:44:07 by cmariot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#! /bin/sh

WORDPRESS_CONFIG=/var/www/wordpress/

# Download wordpress and untar it
download_wordpress()
{
	cd /var/www
	wget https://wordpress.org/latest.tar.gz
	tar -xvzf latest.tar.gz
	rm latest.tar.gz
}

# Configuration of wp-config.php
update_wp_config_files()
{
	cd /var/www/wordpress
	# MariaDB Variables
	sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '${MYSQL_DATABASE}' );/g"		wp-config-sample.php
	sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', '${MYSQL_USER}' );/g"				wp-config-sample.php
	sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );/g"	wp-config-sample.php
	sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', 'mariadb:3306' );/g"						wp-config-sample.php
	# Change Authentification unique keys
	wget -O salts.txt https://api.wordpress.org/secret-key/1.1/salt/
	head -50 wp-config-sample.php			> tmp_file.php
	cat salts.txt							>> tmp_file.php
	tail -38 wp-config-sample.php			>> tmp_file.php
	echo "define('FS_METHOD', 'direct');"	>> tmp_file.php
	sed 's/\r//' tmp_file.php				> wp-config.php
	rm -f tmp_file.php salts.txt wp-config-sample.php
}

remove_unused_plugins_and_themes()
{
	# Plugins
	rm -rf /var/www/wordpress/wp-content/plugins/akismet \
		/var/www/wordpress/wp-content/plugins/hello.php \
		/var/www/wordpress/wp-content/plugins/index.php
	# Themes
	rm -rf /var/www/wordpress/wp-content/themes/twentytwenty \
		/var/www/wordpress/wp-content/themes/twentytwentyone
}

if [ ! -z "$(ls -A $WORDPRESS_CONFIG)" ];
then

	echo "WordPress is already downloaded."

else

	echo "Wordpress installation ..."
	download_wordpress
	update_wp_config_files
	remove_unused_plugins_and_themes
	echo "The WordPress installation is completed."

fi

exec php-fpm8 -F -R
