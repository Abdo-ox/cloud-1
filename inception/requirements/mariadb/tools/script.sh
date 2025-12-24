#!/bin/bash

if [ ! -f /var/lib/mysql/password_changed ]; then
    echo "the first run ################"
    service mariadb start
    until mysqladmin ping --socket=/run/mysqld/mysqld.sock --silent; do
        sleep 1
    done
    echo "the first run ################1"
    mysql -e " CREATE DATABASE IF NOT EXISTS ${SQL_NAME};
    CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
    GRANT ALL PRIVILEGES ON ${SQL_NAME}.* TO '${SQL_USER}'@'%';
    FLUSH PRIVILEGES;"
    echo "the first run ################2"
    mysqladmin shutdown
    echo "the first run ################3"
    touch /var/lib/mysql/password_changed
fi

exec mysqld_safe



