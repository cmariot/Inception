# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    wordpress_istall.sh                                :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmariot <cmariot@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/07 14:15:26 by cmariot           #+#    #+#              #
#    Updated: 2022/09/15 15:16:17 by cmariot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#! /bin/sh

WORDPRESS_CONFIG=/var/www/wordpress/

if [ ! -z "$(ls -A $WORDPRESS_CONFIG)" ];
then

	echo "WordPress is already downloaded."

else

	echo "Wordpress installation ..."

	cd /var/www

	# Download wordpress and untar it
	wget http://wordpress.org/latest.tar.gz
	tar -xvzf latest.tar.gz
	rm latest.tar.gz

	cd wordpress

	# Configuration of wp-config.php
	sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '${MYSQL_DATABASE}' );/g"		wp-config-sample.php
	sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', '${MYSQL_USER}' );/g"				wp-config-sample.php
	sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '${MYSQL_PASSWORD}' );/g"	wp-config-sample.php
	sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', 'mariadb:3306' );/g"						wp-config-sample.php


	# Change Authentification unique keys

	mv wp-config-sample.php wp-config.php
	
	echo "The WordPress installation is completed."

fi

php-fpm8 -F -R
