#!/bin/bash
#Check that this is beeing executed with elevated privileges, for the moment the error will make clear it should be

zypper in -n nginx php8 php8-bcmath php8-devel php8-dom php8-fpm composer php8-opcache php8-mbstring php8-fileinfo php8-curl php8-mysql php8-soap php8-shmop php8-tidy php8-intl php8-gd php8-gettext php8-gmp
