FROM php:7.4-fpm

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt -yqq update
RUN apt -yqq install libxml2-dev
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install xml
RUN docker-php-ext-install intl

RUN apt-get update && apt-get install -y wget git unzip vim libssl-dev openssl libpng-dev libgd-dev libpq-dev cron curl tesseract-ocr

RUN pecl install xdebug-3.0.1 \
    && docker-php-ext-enable xdebug

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd xdebug bcmath bz2 calendar exif gettext shmop redis sockets yaml xsl xmlrpc


RUN echo "xdebug.force_error_reporting=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.client_host=192.168.221.1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.start_with_request=true" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN apt-get update && apt-get install -y \
    libpng-dev \
    && docker-php-ext-install -j$(nproc) pgsql iconv xml soap opcache pdo pdo_pgsql

RUN git config --global user.email "$DEVELOPER_EMAIL"
RUN git config --global user.name "$DEVELOPER_NAME"

RUN wget https://getcomposer.org/installer -O - -q \
    | php -- --install-dir=/bin --filename=composer --quiet

ENV COMPOSER_ALLOW_SUPERUSER 1

EXPOSE 80

WORKDIR /var/www/html