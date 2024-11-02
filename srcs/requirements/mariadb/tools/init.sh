#!/bin/sh

main () {
    mariadb-install-db
    #mysqld
    local mysql_pass=$(cat $MYSQL_PASSWORD)
    mariadbd -u mysql --bootstrap << EOF
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
CREATE DATABASE $MYSQL_DATABASE;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$mysql_pass';
GRANT ALL PRIVILEGES on wordpress.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$mysql_pass';
FLUSH PRIVILEGES;
exit;
EOF
    # Start the MariaDB daemon
    exec /usr/bin/mariadbd --datadir='/var/lib/mysql'
}

main

exit $?
