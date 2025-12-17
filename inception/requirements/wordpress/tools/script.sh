#!/bin/bash
#download worpress files
if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root --path="$WP_PATH" --locale="$WP_LANG"
    cp -R /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
    sed -i "s/database_name_here/$SQL_NAME/g"     /var/www/html/wp-config.php
    sed -i "s/username_here/$SQL_USER/g"          /var/www/html/wp-config.php
    sed -i "s/password_here/$SQL_PASSWORD/g"       /var/www/html/wp-config.php
    sed -i "s/localhost/$SQL_HOST/g"       /var/www/html/wp-config.php
    sleep 2
    wp core install --allow-root --path="$WP_PATH" --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASS" --admin_email="$WP_ADMIN_EMAIL"
    wp user create --allow-root --path="$WP_PATH" "$WP_USERNAME" abdoox2016@gmail.com --role=subscriber --user_pass="$WP_USERPASS"
fi

exec php-fpm7.4 -F