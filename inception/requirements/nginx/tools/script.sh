#!/bin/bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/my.key -out /etc/nginx/ssl/my.crt -subj "/C=MO/L=BG/O=1337/OU=student/CN=ajari.42.fr" > /dev/null 2>&1
sed -i "s#/path/to/crt#$CERTS_#g" /etc/nginx/nginx.conf
sed -i "s#S_NAME#$DOMAIN_NAME#g" /etc/nginx/nginx.conf
exec nginx -g 'daemon off;'