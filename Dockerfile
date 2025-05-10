FROM dunglas/frankenphp:php8.3

ENV SERVER_NAME=":80"

WORKDIR /app

COPY . /app

RUN  apt-get update -y && \
     apt-get upgrade -y && \
     apt-get dist-upgrade -y && \
     apt-get -y autoremove && \
     apt-get clean

RUN apt install -y p7zip p7zip-full zip libzip-dev && \
  docker-php-ext-install zip pcntl && \
  docker-php-ext-enable zip

COPY --from=composer:2.2  /usr/bin/composer /usr/bin/composer

RUN composer install