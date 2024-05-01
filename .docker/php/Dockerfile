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
COPY --from=composer:2.7.4 /usr/bin/composer /usr/bin/composer  
RUN mkdir /var/composer  
ENV COMPOSER_HOME /var/composer  
ENV COMPOSER_ALLOW_SUPERUSER 1 

#xdebug.
RUN pecl install -o -f xdebug-3.3.2 && rm -rf /tmp/pear

WORKDIR /usr/local/apache2/www

CMD ["php-fpm"]
