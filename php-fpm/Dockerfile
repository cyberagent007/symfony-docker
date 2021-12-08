FROM php:7.4-fpm
ARG USER=${USER}
ARG GROUP=${GROUP}
ENV TZ=Europe/London
ARG XDEBUG_REMOTE_HOST

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y software-properties-common \
    && apt-get install --no-install-recommends -y \
      net-tools \
      procps \
      vim \
      ca-certificates \
      librabbitmq-dev \
      zlib1g-dev \
      libssl-dev \
      openssl \
      libmcrypt-dev \
      libpng-dev \
      libgd-dev \
      zip \
      unzip \
      libicu-dev \
      curl \
      supervisor \
      cron

RUN pecl install apcu \
    && pecl install apcu_bc-1.0.3 \
    && docker-php-ext-enable apcu --ini-name 10-docker-php-ext-apcu.ini \
    && docker-php-ext-enable apc --ini-name 20-docker-php-ext-apc.ini

RUN pecl install amqp && docker-php-ext-enable amqp

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure intl

RUN docker-php-ext-install \
       pdo_mysql \
       zip \
       iconv \
       gd \
       opcache \
       bcmath \
       intl

RUN useradd www && usermod -G www-data www

RUN mkdir /var/run/supervisor
RUN chown -R www.www /var/run/supervisor

COPY ./entry-point.sh /entry-point.sh
COPY ./wait-for-it.sh /wait-for-it.sh
COPY ./generate_jwt_keys.sh /generate_jwt_keys.sh
COPY ./create_var_dir.sh /create_var_dir.sh
COPY ./php.ini /usr/local/etc/php/php.ini
COPY ./php.ini /usr/local/etc/php/php.ini
COPY ./www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./php.ini /etc/php/7.4/fpm/conf.d/99-docker.ini
COPY ./cronjobs/crontasks /etc/cron.d/crontasks

EXPOSE 80

COPY .docker/php-fpm/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY .docker/php-fpm/php.ini /etc/php/7.4/fpm/php.ini

RUN pecl install xdebug-2.6.0  && docker-php-ext-enable xdebug \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_connect_back=off" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_log=/var/log/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini \
    && echo "xdebug.remote_host=$XDEBUG_REMOTE_HOST" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN touch /var/log/xdebug.log
RUN chmod 0777 /var/log --recursive

CMD ["cron", "-f"]

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


WORKDIR /var/www/html/