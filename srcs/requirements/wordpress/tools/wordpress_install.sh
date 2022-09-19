#! /bin/sh


WORDPRESS_CONFIG=/var/www/wordpress/


# Download wordpress and untar it
download_wordpress()
{
	cd /var/www
	curl -o latest-fr_FR.tar.gz https://fr.wordpress.org/latest-fr_FR.tar.gz
	tar -xvzf latest-fr_FR.tar.gz
	rm latest-fr_FR.tar.gz
}


# Configuration of wp-config.php
update_wp_config_files()
{
	cd /var/www/wordpress
	# MariaDB Variables
	sed -i "s/'votre_nom_de_bdd'/'${MYSQL_DATABASE}'/g"										wp-config-sample.php
	sed -i "s/'votre_utilisateur_de_bdd'/'${MYSQL_USER}'/g"									wp-config-sample.php
	sed -i "s/'votre_mdp_de_bdd'/'${MYSQL_PASSWORD}'/g"										wp-config-sample.php
	sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', 'mariadb:3306' );/g"		wp-config-sample.php
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


main()
{
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
}


main
exec php-fpm8 -F
