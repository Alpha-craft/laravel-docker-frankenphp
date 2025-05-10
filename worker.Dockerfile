FROM php:8.4-cli

COPY --chown=www-data:www-data . /app

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install -y zip libzip-dev && \
  docker-php-ext-install zip pcntl && \
  docker-php-ext-enable zip

COPY --from=composer:2.2  /usr/bin/composer /usr/bin/composer



RUN composer install &&\
    composer require laravel/octane && \
    php artisan octane:install --server=frankenphp

EXPOSE 8000

CMD php artisan octane:start --server=frankenphp --host=0.0.0.0 --port=8000