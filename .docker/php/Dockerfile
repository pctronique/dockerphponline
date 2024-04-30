FROM php:8.3.7RC1-fpm

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
RUN apt install -y vim curl debconf subversion apt-transport-https apt-utils build-essential locales acl mailutils wget
RUN apt install -y libjpeg-dev libpng-dev libmcrypt-dev unzip git
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
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.10.1.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail

RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap

# Install YAML extension
RUN pecl install yaml && echo "extension=yaml.so" > /usr/local/etc/php/conf.d/ext-yaml.ini
    
# Goto temporary directory.
WORKDIR /tmp

# Install composer  
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer  
RUN mkdir /var/composer  
ENV COMPOSER_HOME /var/composer  
ENV COMPOSER_ALLOW_SUPERUSER 1 

#xdebug.
RUN pecl install -o -f xdebug && rm -rf /tmp/pear
RUN composer selfupdate && \
    composer require "phpunit/phpunit:8.*.*" --prefer-source --no-interaction && \
    ln -s /tmp/vendor/bin/phpunit /usr/local/bin/phpunit

WORKDIR /usr/local/apache2/www

CMD ["php-fpm"]
