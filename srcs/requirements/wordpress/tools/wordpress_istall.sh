# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    wordpress_istall.sh                                :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmariot <cmariot@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/07 14:15:26 by cmariot           #+#    #+#              #
#    Updated: 2022/09/08 23:01:33 by cmariot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#! /bin/sh

WORDPRESS_CONFIG=/var/www/wordpress/

if [ ! -z "$(ls -A $WORDPRESS_CONFIG)" ];
then

	echo "WordPress is already downloaded."

else

	echo "Wordpress instalation"

	cd /var/www

	# Download wordpress and untar it
	wget http://wordpress.org/latest.tar.gz
	tar -xvzf latest.tar.gz
	rm latest.tar.gz

	cd wordpress

	# Configuration of wp-config.php
	sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '${DB_NAME}' );/g"			wp-config-sample.php
	sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', '${DB_USER}' );/g"				wp-config-sample.php
	sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '${DB_PASSWORD}' );/g"	wp-config-sample.php
	sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', '${DB_HOST}' );/g"					wp-config-sample.php

	# Change Authentification unique keys

	mv wp-config-sample.php wp-config.php

fi

php-fpm8 -F -R
