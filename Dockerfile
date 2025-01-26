# Use the PHP FPM image
FROM php:8.4-apache

# Install necessary dependencies (e.g., Composer, Git, Apache, and mod_proxy_fcgi)
RUN apt-get update && apt-get install -y \
    unzip \
    git \
    apache2 \
    libapache2-mod-fcgid \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && apt-get clean

RUN docker-php-ext-install mysqli

# Enable mod_proxy and mod_rewrite for Apache to work with PHP-FPM
RUN a2enmod proxy_fcgi && a2enmod rewrite

# Set the working directory where the WordPress files will be installed
WORKDIR /var/www/html

COPY ./html /var/www/html

# Expose the Apache web server port
EXPOSE 80
