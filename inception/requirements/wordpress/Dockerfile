FROM debian:oldstable

ARG SQL_NAME
ARG SQL_USER
ARG SQL_PASSWORD
ARG SQL_HOST
ARG WP_LANG
ARG WP_PATH

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg2 \
    lsb-release \
    apt-transport-https \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*
RUN curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /usr/share/keyrings/php.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" \
       > /etc/apt/sources.list.d/php.list

# Install PHP 7.4 FPM and common extensions
RUN apt-get update 

RUN  apt-get install -y \
    php7.4-fpm \
    php7.4-cli \
    php7.4-mysql \
    php7.4-curl \
    php7.4-xml \
    php7.4-mbstring \
    php7.4-intl \
    php7.4-gd \
    && apt-get install wget \
    && apt-get install sendmail -y \
    && rm -rf /var/lib/apt/lists/*

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && cp -R wp-cli.phar /usr/local/bin/wp

COPY conf/php-fpm-config.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p "$WP_PATH"
RUN wp core download --allow-root --path="$WP_PATH" --locale="$WP_LANG"
RUN cp -R /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
RUN echo $SQL_NAME > hello
RUN sed -i "s/database_name_here/$SQL_NAME/g"     /var/www/html/wp-config.php
RUN sed -i "s/username_here/$SQL_USER/g"          /var/www/html/wp-config.php
RUN sed -i "s/password_here/$SQL_PASSWORD/g"       /var/www/html/wp-config.php
RUN sed -i "s/localhost/$SQL_HOST/g"       /var/www/html/wp-config.php

COPY ./tools/script.sh /
RUN chmod 777 /script.sh

EXPOSE 9000

CMD ["/script.sh"]