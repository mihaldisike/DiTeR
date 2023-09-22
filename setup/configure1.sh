#!/bin/bash
#In theory this file should be called like 
#wget it or git clone the repo, and than call this .sh file. from it the script will start to handle all the stuff that is needed.
#Check that this is beeing executed with elevated privileges, for the moment the error will make clear it should be
#The objective is to have the ability to SERVE PHP WEBPAGES, using nginx, using php-fpm WITH a php user that has SUDO priviledge
#this data MUST be served ONLY on 127.0.0.1 interface! 
#use as a reference https://github.com/dublinbranch/serverConfig/blob/master/php8
#https://github.com/dublinbranch/serverConfig/blob/master/nginx.sh
#also create the basic db and stuff to initialize the software after

zypper in -n nginx php8 php8-bcmath php8-devel php8-dom php8-fpm composer php8-opcache php8-mbstring php8-fileinfo php8-curl php8-mysql php8-soap php8-shmop php8-tidy php8-intl php8-gd php8-gettext php8-gmp findutils 

printf "\n" | pecl install apcu
echo "extension = apcu.so" > /etc/php8/conf.d/apcu.ini

cd /etc/php8/fpm
cp php-fpm.conf.default php-fpm.conf
cd php-fpm.d/
cp www.conf.default www.conf

systemctl start php-fpm.service
systemctl enable php-fpm.service
systemctl start nginx.service 
systemctl enable nginx.service
