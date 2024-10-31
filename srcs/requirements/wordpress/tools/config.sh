#!/bin/sh

FICHIER="exists.txt"

mkdir -p /run/php/ /var/www/html

if [ -f "/var/www/html/$FICHIER" ]; then
    echo "Le fichier de configuration existe ($FICHIER)"
else
    echo "Le fichier de configuration n'existe pas ($FICHIER). On demarre l'installation"

	cd /var/www/html
    wp-cli.phar core download

	wp-cli.phar config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$MYSQL_PASSWORD" \
        --dbhost="mariadb:3306"

	# to avoid discolsing admin password to bash history (the usefulness is to be talked about)
	# wp core install --url=yourdomain.com --title=Site_Title --admin_user=admin_username --admin_email=your@email.com --prompt=admin_password < admin_password.txt
	# or
	wp-cli.phar core install --url=$DOMAIN_NAME --title=Example --admin_user=$ADMIN_USER --admin_password=$ADMIN_PASS --admin_email=$ADMIN_EMAIL --allow-root
	wp-cli.phar user create bob bob@example.com --role=author

	touch /var/www/html/$FICHIER
fi
php-fpm82 -F -R
