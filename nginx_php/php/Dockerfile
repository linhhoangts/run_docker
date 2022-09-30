FROM php:7.2-fpm

RUN apt-get update && apt-get install -y libzip-dev zip
RUN docker-php-ext-install mysqli zip