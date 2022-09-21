#! /bin/sh

# If adminer isn't installed
if [ ! -f "/var/www/wordpress/adminer.php" ];
then
	# Install adminer
	cd /var/www/wordpress
	wget -O "adminer.php" "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php"
fi
