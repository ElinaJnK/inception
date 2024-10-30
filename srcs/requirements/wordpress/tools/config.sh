#!/bin/sh

sleep 10
FICHIER=exists.txt

if [ -f "$FICHIER" ]; then
    echo "Le fichier de configuration existe ($FICHIER)"
else
    echo "Le fichier de configuration n'existe pas ($FICHIER). On demarre l'installation"

    ./wp-cli.phar core download

	./wp-cli.phar config create --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306 #--dbprefix=wp_ # --path='/var/www/wordpress'
	# to avoid discolsing admin password to bash history (the usefulness is to be talked about)
	# wp core install --url=yourdomain.com --title=Site_Title --admin_user=admin_username --admin_email=your@email.com --prompt=admin_password < admin_password.txt
	# or
	./wp-cli.phar core install --url=example.com --title=Example --admin_user=supervisor --admin_password=strongpassword --admin_email=info@example.com
	./wp-cli.phar user create bob bob@example.com --role=author
	if [ -d "/run/php/" ]; then
		echo "/run/php already exists"
	else
		echo "creating /run/php"
		mkdir -p /run/php/
	fi
	touch $FICHIER
fi
php-fpm82 -F -R
