#!/bin/bash

# Destination of env file inside container
ENV_FILE="/var/www/.env"

# Loop through XDEBUG, PHP_IDE_CONFIG and REMOTE_HOST variables and check if they are set.
# If they are not set then check if we have values for them in the env file, if the env file exists. If we have values
# in the env file then add exports for these in in the ~./bashrc file.
for VAR in XDEBUG PHP_IDE_CONFIG REMOTE_HOST
do
  if [ -z "${!VAR}" ] && [ -f "${ENV_FILE}" ]; then
    VALUE=$(grep $VAR $ENV_FILE | cut -d '=' -f 2-)
    if [ ! -z "${VALUE}" ]; then
      # Before adding the export we clear the value, if set, to prevent duplication.
      sed -i "/$VAR/d"  ~/.bashrc
      echo "export $VAR=$VALUE" >> ~/.bashrc;
    fi
  fi
done


# Source the .bashrc file so that the exported variables are available.
. ~/.bashrc

# Toggle xdebug
if [ "true" == "$XDEBUG" ] && [ ! -f /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini ]; then
      # Reference link for config settings https://xdebug.org/docs/all_settings
      # Reference link for up Xdebug with PhpStorm https://www.jetbrains.com/help/phpstorm/debugging-with-phpstorm-ultimate-guide.html
      docker-php-ext-enable xdebug && \
      echo "xdebug.client_host=$REMOTE_HOST" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini;  \
      echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
      echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
      echo "xdebug.xdebug.start_upon_error=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
      echo "xdebug.discover_client_host.=0" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
      echo "xdebug.client_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
      echo "xdebug.log=/var/log/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini; \
      echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini;  \

fi

exec "$@"