FROM php:7.0.26-fpm-jessie

MAINTAINER "William Tran" <will@wtran.net>

ADD conf/m2dev.crt /etc/nginx/ssl/m2dev.crt
ADD conf/m2dev.key /etc/nginx/ssl/m2dev.key
ADD conf/magento.conf /etc/nginx/conf.d/magento.conf
ADD conf/supervisord.conf /etc/supervisord.conf
ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
ADD scripts/phpcli-debug.sh /usr/bin/phpcli-debug
ADD conf/docker-php-cli.ini /usr/local/etc/php/php.ini

RUN \
    echo 'deb http://nginx.org/packages/debian/ jessie nginx' >> /etc/apt/sources.list && \
    echo 'deb-src http://nginx.org/packages/debian/ jessie nginx' >> /etc/apt/sources.list && \
    curl http://nginx.org/keys/nginx_signing.key | apt-key add - && \
    apt-get update && \
    apt-get install -y \
        nginx=1.8.1-1~jessie \
        apt-utils \
        supervisor \
        vim \
        less \
        curl \
        mysql-client \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev libxslt1-dev \
        libicu-dev \
        libpng12-dev \
        git \
        telnet \
        net-tools \
        lsof \
        gzip \
    && \
    rm -rf /etc/nginx/conf.d/default.conf && \
    rm -rf /etc/nginx/conf.d/example_ssl.conf && \
    sed -i '/^listen /c \listen = \/var\/run\/php-fpm.sock' /usr/local/etc/php-fpm.d/zz-docker.conf && \
    sed -i '/^;listen.owner /c \listen.owner = www-data' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i '/^;listen.group /c \listen.group = www-data' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i '/^;listen.mode /c \listen.mode = 0660' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i '/^pm.max_children /c \pm.max_children = 16' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i '/^pm.max_spare_servers /c \pm.max_spare_servers= 4' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i '/^pm.start_servers /c \pm.start_servers = 2' /usr/local/etc/php-fpm.d/www.conf && \
    sed -i '/^include/c \include=\/usr\/local\/etc\/php-fpm.d/*.conf' /usr/local/etc/php-fpm.conf && \
    sed -i '/^user /c \user www-data;' /etc/nginx/nginx.conf && \
    sed -i '/^worker_processes /c \worker_processes 2;' /etc/nginx/nginx.conf && \
    rm -rf /var/lib/apt/lists/* && \
    chmod u+x /usr/local/bin/entrypoint.sh && \
    docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
    docker-php-ext-configure hash --with-mhash && \
    docker-php-ext-install -j$(nproc) mcrypt intl xsl gd zip pdo_mysql opcache soap bcmath json iconv dom mbstring && \
    pecl install xdebug && \
    docker-php-ext-enable xdebug

ADD conf/zz-custom.ini /usr/local/etc/php/conf.d/zz-custom.ini
ADD scripts/n98-magerun2.phar.bash /etc/bash_completion.d/n98-magerun2.phar.bash
ADD scripts/n98-magerun2.yaml /etc/n98-magerun2.yaml

ENV SHELL /bin/bash

WORKDIR /var/www/magento

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
