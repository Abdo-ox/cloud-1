#!/bin/bash
#download worpress files

wp core install --allow-root --path="$WP_PATH" --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASS" --admin_email="$WP_ADMIN_EMAIL"
if ! wp user get "$WP_USERNAME" --allow-root --path="$WP_PATH" >/dev/null 2>&1; then
    wp user create --allow-root --path="$WP_PATH" "$WP_USERNAME" "$WP_EMAIL" --role=subscriber --user_pass="$WP_USERPASS"
fi
stdbuf -oL echo "wordpress is running"
exec php-fpm7.4 -F