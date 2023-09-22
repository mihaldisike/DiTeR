#!/bin/bash
#Check that this is beeing executed with elevated privileges, for the moment the error will make clear it should be

#The objective is to have the ability to SERVE PHP WEBPAGES, using nginx, using php-fpm WITH a php user that has SUDO priviledge
#this data MUST be served ONLY on 127.0.0.1 interface! 

#use as a reference https://github.com/dublinbranch/serverConfig/blob/master/php8
#https://github.com/dublinbranch/serverConfig/blob/master/nginx.sh

#also create the basic db and stuff to initialize the software after


zypper in -n nginx php8 php8-bcmath php8-devel php8-dom php8-fpm composer php8-opcache php8-mbstring php8-fileinfo php8-curl php8-mysql php8-soap php8-shmop php8-tidy php8-intl php8-gd php8-gettext php8-gmp
