#!/bin/sh
##################################################################################################
##   This shell installs and configures the latest NextCloud version in a debian environment.   ##
#                               Written by Lemon Tree on 17/08/2021                              #
## Running the ubuntu_20_04_deploy_LNMP_stack.sh installer is required before running this one. ##
#                         Usage - sudo ubuntu_20_04_deploy_nextcloud.sh                          #
#  Sources - https://www.linuxbabe.com/ubuntu/install-nextcloud-ubuntu-20-04-apache-lamp-stack   #
##################################################################################################

## Exit codes ##
SUCCESS="1"                                                                                      # The shell ran with success and no execution error occured. Check console logs for further details.
ERROR_DB_MISSING="2"                                                                             # The shell detected that MySQL (or MariaDB) is not installed on this device. Please consider running the LNMP Stack deploymnent shell.
ERROR_PHP_MISSING="3"                                                                            # The shell detected that PHP is not installed on this device. Please consider running the LNMP Stack deploymnent shell.
ERROR_WEB_SERVER_MISSING="4"                                                                     # The shell detected that none of the supported web servers (Apache 2 or Nginx) is installed on this device. Please consider running the LNMP Stack deploymnent shell.

## System variables ##
APT=$(which "apt")
CHOWN=$(which "chown")
DATE=$(which "date")
MKDIR=$(which "mkdir")
SED=$(which "sed")
#SUDO=$(which "sudo")
WGET=$(which "wget")

## User-defined variables ##
NC_VERSION="22.1.0"                                                                              # NextCloud version to download and install
NC_DATA_FOLDER="/var/www/nextcloud-data"                                                         # Folder where NextCloud will store the user profiles (uploaded data, settings, etc.) This folder path must be entered when initialising the web installer.

## Creating $CURRENT_DATE variable ##
CURRENT_DATE="$DATE +%Y-%m-%d-%H%M%S"
echo "\n$($CURRENT_DATE): The script has started."

## Verifying if LAMP or LNMP stack is installed before continuing ##
APACHE2=$(which "apache2")
MYSQL=$(which "mysql")
NGINX=$(which "nginx")
PHP=$(which "php")
if [ -f $NGINX ] || [ -f $APACHE2 ] && [ -f $MYSQL ] && [ -f $PHP ]; then                        # At this point, all pre-requisites are met and we create the $WEB_SERVER variable containing the web server that is installed on the device. It will be used by this shell later.
  if [ -f $NGINX ] && [ ! -f $APACHE2 ]; then
    WEB_SERVER="Nginx"
  elif [ ! -f $NGINX ] && [ -f $APACHE2 ]; then
    WEB_SERVER="Apache2"
  elif [ -f $NGINX ] && [ -f $APACHE2 ]; then
    WEB_SERVER="Both"
  fi
  echo "\n$($CURRENT_DATE): All NextCloud pre-requisites are met. Web server is $WEB_SERVER.\n\n$($CURRENT_DATE): Proceeding to installation..."
elif [ ! -f $NGINX ] || [ ! -f $APACHE2 ] && [ -f $MYSQL ] && [ -f $PHP ]; then
  echo "\n$($CURRENT_DATE): Web server is missing. Please consider running the LNMP installation shell before retrying.\n\n$($CURRENT_DATE): Abort.\n"
  exit $ERROR_WEB_SERVER_MISSING
elif [ -f $NGINX ] || [ -f $APACHE2 ] && [ ! -f $MYSQL ] && [ -f $PHP ]; then
  echo "\n$($CURRENT_DATE): Database pre-requisites are missing. Please consider running the LNMP installation shell before retrying.\n\n$($CURRENT_DATE): Abort.\n"
  exit $ERROR_DB_MISSING
elif [ -f $NGINX ] || [ -f $APACHE2 ] && [ -f $MYSQL ] && [ ! -f $PHP ]; then
  echo "\n$($CURRENT_DATE): PHP is missing. Please consider running the LNMP installation shell before retrying.\n\n$($CURRENT_DATE): Abort.\n"
  exit $ERROR_PHP_MISSING
fi

## Download shell pre-requisites (and declare their system variables) ##
#$SUDO
$APT install "unzip"
UNZIP=$(which "unzip")

## Download the latest version of NextCloud ##
$WGET https://download.nextcloud.com/server/releases/nextcloud-$NC_VERSION.zip

## Extract the downloaded ZIP archive to web root ##
#$SUDO
$UNZIP nextcloud-$NC_VERSION.zip -d "/var/www/"

## Apply correct permissions on extracted applicative files ##
#$SUDO
$CHOWN www-data:www-data "/var/www/nextcloud/" -R

## NextCloud PHP pre-requisites ##
#$SUDO
$APT install "imagemagick" "php-imagick" "libapache2-mod-php7.4" "php7.4-common" "php7.4-mysql" "php7.4-fpm" "php7.4-gd" "php7.4-json" "php7.4-curl" "php7.4-zip" "php7.4-xml" "php7.4-mbstring" "php7.4-bz2" "php7.4-intl" "php7.4-bcmath" "php7.4-gmp"

## Create NextCloud Data folder ##
#$SUDO
$MKDIR "$NC_DATA_FOLDER"

## Apply correct permissions on NextCloud data folder ##
#$SUDO
$CHOWN www-data:www-data "$NC_DATA_FOLDER" -R

## Change PHP memory size (in MB) ##
#$SUDO
$SED -i 's/memory_limit = 128M/memory_limit = 2048M/g' "/etc/php/7.4/apache2/php.ini"            # Change default PHP-FPM memory limit from 128MB to 2048MB (512MB = minimum required by NextCloud)

## Change PHP max upload size (in MB) ##
#$SUDO
$SED -i 's/upload_max_filesize = 2M/upload_max_filesize = 20480M/g' "/etc/php/7.4/fpm/php.ini"   # Change default upload_max_filesize from 2MB to 20480MB
#$SUDO
$SED -i 's/post_max_size = 2M/post_max_size = 20480M/g' "/etc/php/7.4/fpm/php.ini"               # Change default post_max_size from 2MB to 20480MB

## Exit ##
exit 0
