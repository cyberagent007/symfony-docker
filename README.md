# Symfony | docker-compose repository

## About

System development environment for Symfony projects.

## Commands list
```
./bin/composer.bash - is alias for Composer inside php-fpm container

./bin/login-php-fpm.bash - login inside container

./bin/php-exec.bash - bash terminal inside container

./bin/php.bash - aliass for php-cli inside container

./bin/start.bash - aliass for docker-compose up -d --build

./bin/stop.bash - aliass for docker-compose down

```
## Services

**Web url**
storebot.local/

**Adminer**

Location: http://storebot.local:8080/

## Credentials 

**Postgres**

``
POSTGRES_DB: 'slaveapp_db'
POSTGRES_USER: 'slave_user'
POSTGRES_PASSWORD: '124fFv2GddQds'
``