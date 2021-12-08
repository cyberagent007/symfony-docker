#!/usr/bin/env bash

cd "`dirname \"$0\"`" && \
 docker-compose exec -T "php-fpm" bash -c "cd /var/www/html/ && $*"