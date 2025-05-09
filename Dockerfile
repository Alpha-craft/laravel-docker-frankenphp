FROM dunglas/frankenphp:php8.4

ENV SERVER_NAME=":80"

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install -y zip libzip-dev && \
  docker-php-ext-install zip && \
  docker-php-ext-enable zip

COPY --from=composer:2.2  /usr/bin/composer /usr/bin/composer

RUN composer install