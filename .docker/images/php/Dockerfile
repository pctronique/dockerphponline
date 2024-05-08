# variable environnement
ARG VALUE_PHP_VERSION
ARG DEF_PHP_VERSION=${VALUE_PHP_VERSION}
ARG VALUE_COMPOSER_VERSION
ARG DEF_COMPOSER_VERSION=${VALUE_COMPOSER_VERSION}
# config install composer
FROM composer:${DEF_COMPOSER_VERSION} AS compvers

# config install php
FROM php:${DEF_PHP_VERSION}

# variable version (environnement)
ARG VALUE_XDEBUG_VERSION
ENV DEF_XDEBUG_VERSION=${VALUE_XDEBUG_VERSION}
ARG VALUE_GOLANG_VERSION
ENV DEF_GOLANG_VERSION=${VALUE_GOLANG_VERSION}
ARG GOLANG_VERSION="https://storage.googleapis.com/golang/go${DEF_GOLANG_VERSION}.linux-amd64.tar.gz"
ENV XDEBUG_VERSION=${DEF_XDEBUG_VERSION:+"xdebug-${DEF_XDEBUG_VERSION}"}
ENV XDEBUG_VERSION=${XDEBUG_VERSION:-'xdebug'}

# install package
RUN set -ex
RUN apt update
RUN apt upgrade -y  
RUN apt install -y libxml2-dev 
RUN apt install -y libldb-dev
RUN apt install -y libldap2-dev
RUN apt install -y libssl-dev
RUN apt install -y libxslt-dev
RUN apt install -y wget
RUN apt install -y graphviz
RUN apt install -y libzip-dev
RUN apt install -y vim
RUN apt install -y curl
RUN apt install -y debconf
RUN apt install -y subversion
RUN apt install -y apt-transport-https
RUN apt install -y apt-utils
RUN apt install -y build-essential
RUN apt install -y locales
RUN apt install -y acl
RUN apt install -y mailutils
RUN apt install -y wget
RUN apt install -y libjpeg-dev
RUN apt install -y libpng-dev
RUN apt install -y libmcrypt-dev
RUN apt install -y unzip
RUN apt install -y cron
#pour mailhog 
RUN apt install --no-install-recommends --assume-yes --quiet ca-certificates curl git
RUN apt install -y libc-client-dev libkrb5-dev
#pour YAML extension
RUN apt install libyaml-dev -y
#del list
RUN rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd --with-jpeg
RUN docker-php-ext-install -j5 gd mysqli pdo_mysql xsl zip
   
#install mailhog
RUN curl -Lsf ${GOLANG_VERSION} | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail


RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap

RUN groupadd docker

# Install YAML extension
RUN pecl install yaml && echo "extension=yaml.so" > /usr/local/etc/php/conf.d/ext-yaml.ini
    
# Goto temporary directory.
WORKDIR /tmp

# Install composer  
COPY --from=compvers /usr/bin/composer /usr/bin/composer  
RUN mkdir /var/composer  
ENV COMPOSER_HOME /var/composer  
ENV COMPOSER_ALLOW_SUPERUSER 1 

RUN mkdir -p /var/docker/php
RUN mkdir -p /var/log/docker/php
RUN mkdir -p /var/log/docker/xdebug
RUN mkdir -p /var/tmp/docker/php
RUN mkdir -p /var/spool/cron/crontabs

# xdebug.
RUN pecl install -o -f ${XDEBUG_VERSION} && rm -rf /tmp/pear
COPY xdebug_extends.sh /var/docker/php/
RUN chmod +x /var/docker/php/xdebug_extends.sh
RUN /var/docker/php/xdebug_extends.sh

COPY importdata.sh /var/docker/php/
COPY docker-data-entrypoint.sh /var/docker/php/
RUN chmod +x /var/docker/php/importdata.sh
RUN chmod +x /var/docker/php/docker-data-entrypoint.sh

ENTRYPOINT ["/var/docker/php/docker-data-entrypoint.sh", "docker-php-entrypoint"]

WORKDIR /usr/local/apache2/www

CMD ["php-fpm"]
