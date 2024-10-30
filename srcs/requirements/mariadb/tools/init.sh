#!/bin/sh

main () {
    mariadb-install-db
    #mysqld
    mariadbd -u mysql --bootstrap << EOF
create database wordpress;
create database elino;
flush privileges;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
CREATE DATABASE karimo;
GRANT ALL PRIVILEGES on wordpress.* TO 'elino'@'%' IDENTIFIED BY 'pwd';
FLUSH PRIVILEGES;"
exit
EOF
    exec mariadbd
    
}

main

exit $?
