FROM example/php:7.4

# Copy codebase
COPY . ./

# Install dependencies
RUN composer install

# Finish composer
RUN composer dump-autoload --no-scripts --no-dev --optimize

# Finish setup
COPY ./docker/app/entrypoint.sh /scripts/entrypoint.sh
RUN mkdir -p /storage && \
    mv /var/www/storage/* /storage && \
    chmod +x /var/www/artisan && \
    chown -R www-data:www-data /var/www && \
    chown -R www-data:www-data /scripts/ && \
    chmod 777 /scripts/

ENTRYPOINT ["sh", "/scripts/entrypoint.sh"]