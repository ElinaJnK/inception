#!/bin/sh

sleep 10
FICHIER="exists.txt"

mkdir -p /run/php/ /var/www/html

if [ -f "/var/www/html/$FICHIER" ]; then
    echo "Le fichier de configuration existe ($FICHIER)"
else
    echo "Le fichier de configuration n'existe pas ($FICHIER). On demarre l'installation"

	cd /var/www/html
    wp-cli.phar core download

	mysql_pass=$(cat $MYSQL_PASSWORD)

	wp-cli.phar config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$MYSQL_USER" \
        --dbpass="$mysql_pass" \
        --dbhost="mariadb:3306"
		--extra-php <<PHP
define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', '6379' );
define('WP_REDIS_PATH', __DIR__ . '/../redis.sock');
define('WP_REDIS_SCHEME', 'unix');
PHP

	wp-cli.phar core install --url=$DOMAIN_NAME --title=Site_Title --admin_user=$ADMIN_USER --admin_email=your@email.com --allow-root --prompt=admin_password < ${WORDPRESS_ADMIN_PASS} > /dev/null 2>&1
	wp-cli.phar user create $LOGIN $LOGIN@example.com --role=author --allow-root --prompt=user_pass < ${WORDPRESS_USER_PASS} > /dev/null 2>&1

    wp-cli.phar plugin install redis-cache --activate
    
	touch /var/www/html/$FICHIER
fi
php-fpm82 -F -R
