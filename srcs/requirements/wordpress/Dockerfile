FROM alpine:3.19

# HEALTHCHECK --interval=5s --timeout=3s CMD perl mariadb-test-run.pl

RUN apk update && apk upgrade

RUN apk add --no-cache wget nginx php php-fpm php-mysqli php-phar php-mbstring mariadb-client php-opcache php-curl

# RUN wget https://fr.wordpress.org/wordpress-6.6-fr_FR.tar.gz -P /var/www

# RUN cd /var/www && tar -xzf wordpress-6.6-fr_FR.tar.gz && rm wordpress-6.6-fr_FR.tar.gz

# RUN	chown -R root:root /var/www/wordpress

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#COPY wp-su.sh /bin/wp
#RUN chmod +x /bin/wp-cli.phar /bin/wp
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp-cli.phar

COPY tools/www.conf /etc/php82/php-fpm.d/www.conf
COPY tools/config.sh config.sh
RUN chmod +x config.sh
#RUN chmod 755 /var/www/html
CMD [ "./docker-entrypoint.sh" ]
#CMD chmod +x config.sh && ./config.sh
#RUN wp core download
#RUN wp config create --dbname=wordpress --dbuser=user --dbpass=password --dbhost=mariadb --dbprefix=wp_
#RUN wp core install --url=yourdomain.com --title=Site_Title --admin_user=admin_username --admin_password=admin_password --admin_email=your@email.com
