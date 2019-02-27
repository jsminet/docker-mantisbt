FROM php:5.6.40-apache-jessie
MAINTAINER JS Minet

ENV VERSION 2.19.0

RUN apt-get update && apt-get install -y libpng12-dev libjpeg-dev libldap2-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap \
    && docker-php-ext-install mysqli \
    && apt-get purge -y libpng12-dev libjpeg-dev libldap2-dev \
    && curl "https://vorboss.dl.sourceforge.net/project/mantisbt/mantis-stable/${VERSION}/mantisbt-${VERSION}.tar.gz" -o mantisbt.tar.gz \
    && tar -xzf mantisbt.tar.gz \
    && mv mantisbt-$VERSION mantisbt \
    && rm mantisbt.tar.gz \
    && chown -hR www-data:www-data /var/www/html

COPY php.ini /usr/local/etc/php

EXPOSE 80