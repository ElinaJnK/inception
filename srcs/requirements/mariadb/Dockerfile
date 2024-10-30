FROM alpine:3.19
RUN apk update && apk upgrade
RUN apk add --no-cache mariadb mariadb-client


COPY tools/init.sh init.sh
COPY tools/my.cnf.d /etc/my.cnf
RUN mkdir -p /run/mysqld/ /var/lib/mysql
RUN chown -R mysql:mysql /run/mysqld
RUN chown -R mysql:mysql /var/lib/mysql

CMD [ "chmod", "+x", "init.sh", "&&", "./init.sh;" ]
#CMD chmod +x init.sh && ./init.sh