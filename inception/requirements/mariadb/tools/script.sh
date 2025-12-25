#!/bin/bash

mysqld_safe &
pid="$!"

until mysqladmin ping --socket=/run/mysqld/mysqld.sock --silent; do
    sleep 1
done

mysql -e " CREATE DATABASE IF NOT EXISTS ${SQL_NAME};
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${SQL_NAME}.* TO '${SQL_USER}'@'%';
FLUSH PRIVILEGES;"

echo "mariadb is running."
wait "$pid"