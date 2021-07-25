#!/bin/bash
WORKING_DIR="/var/www"

echo "START Composer install"
composer install --ignore-platform-reqs
echo "END Composer install"

echo "Move storage folder"
mv /storage/* $WORKING_DIR/storage
chown -R www-data:www-data $WORKING_DIR/storage

if [ -d $WORKING_DIR ]; then

  cd $WORKING_DIR || exit

  echo "Run migrations"
  php artisan migrate --force

  echo "Cache clear"
  php artisan optimize
  php artisan cache:clear
  php artisan view:clear
  php artisan config:clear

  echo "Geo Install: geo:install"
  php artisan geo:install
  
  echo "Sitemap generate"
  php artisan sitemap:generate

  printf "\nEntrypoint script was successful. \n\nStarting PHP-FPM...\n\n"
  php-fpm

else
  printf "Error: '%s' directory not found!" $WORKING_DIR
  exit 1
fi