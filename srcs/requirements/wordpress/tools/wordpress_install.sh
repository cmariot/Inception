# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    wordpress_install.sh                               :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cmariot <cmariot@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/09/07 14:15:26 by cmariot           #+#    #+#              #
#    Updated: 2022/09/08 01:12:36 by cmariot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#! /bin/sh

WORDPRESS_CONFIG=/var/www/wordpress/

if [ -d "$WORDPRESS_DIR" ];
then
	echo "WordPress is already downloaded."
else
	echo "Wordpress instalation"

	wget http://wordpress.org/latest.tar.gz
	tar -xzf latest.tar.gz
	rm latest.tar.gz

	mkdir -p /var/www/wordpress
	cd /var/www/wordpress

	mv -f /wordpress/* .
	rm -r /wordpress

	sed -i "s/database_name_here/${DB_NAME}/g" wp-config-sample.php
	sed -i "s/username_here/${DB_USER}/g" wp-config-sample.php
	sed -i "s/password_here/${DB_PASSWORD}/g" wp-config-sample.php
	sed -i "s/localhost/${DB_HOST}/g" wp-config-sample.php
	sed -i "s/utf8/${DB_CHARSET}/g" wp-config-sample.php

	find . -name config-sample.php -print | while read line
	do 
		wget http://api.wordpress.org/secret-key/1.1/salt/ -O wp_keys.txt
		sed -i.bak -e '/put your unique phrase here/d' -e \
		'/AUTH_KEY/d' -e '/SECURE_AUTH_KEY/d' -e '/LOGGED_IN_KEY/d' -e '/NONCE_KEY/d' -e \
		'/AUTH_SALT/d' -e '/SECURE_AUTH_SALT/d' -e '/LOGGED_IN_SALT/d' -e '/NONCE_SALT/d' $line
		cat wp_keys.txt >> $line
		rm wp_keys.txt
	done

	mv wp-config-sample.php wp-config.php

fi

php-fpm8 -F -R
