# Use the official PHP-Apache base image
FROM php:8.2-apache

# Enable Apache mod_rewrite
RUN a2enmod rewrite && \
    apt-get update && \
    apt-get install -y default-mysql-client && \
    docker-php-ext-install mysqli pdo pdo_mysql

# Install PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Set working directory inside container
WORKDIR /var/www/html

# Copy composer files and vendor folder first (for dotenv autoload)
COPY composer.json composer.lock ./
COPY vendor/ ./vendor/

# Copy .env into container
# COPY .env .env

# Copy the rest of the app (PHP files, etc.)
COPY . .

# Fix permissions (optional but good practice)
RUN chown -R www-data:www-data /var/www/html

# Expose Apache port
EXPOSE 80

CMD ["apache2-foreground"]
