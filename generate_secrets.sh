#!/bin/sh

mkdir -p secrets

tr -dc 'A-Za-z0-9!?%=' < /dev/urandom | head -c 10 > /secrets/admin_pass.txt
tr -dc 'A-Za-z0-9!?%=' < /dev/urandom | head -c 10 > /secrets/mysql_password.txt
tr -dc 'A-Za-z0-9!?%=' < /dev/urandom | head -c 10 > /secrets/mysql_root_pass.txt
tr -dc 'A-Za-z0-9!?%=' < /dev/urandom | head -c 10 > /secrets/wordpress_db_pass.txt
tr -dc 'A-Za-z0-9!?%=' < /dev/urandom | head -c 10 > /secrets/wordpress_user_pass.txt