#!/bin/bash

#In theory this file should be called like 
#wget it or git clone the repo, and than call this .sh file. from it the script will start to handle all the stuff that is needed.


#Check that this is beeing executed with elevated privileges, for the moment the error will make clear it should be

#The objective is to have the ability to SERVE PHP WEBPAGES, using nginx, using php-fpm WITH a php user that has SUDO priviledge
#this data MUST be served ONLY on 127.0.0.1 interface! 

#use as a reference https://github.com/dublinbranch/serverConfig/blob/master/php8
#https://github.com/dublinbranch/serverConfig/blob/master/nginx.sh

#also create the basic db and stuff to initialize the software after

zypper -n ar --gpgcheck https://download.opensuse.org/repositories/devel:/languages:/php/openSUSE_Leap_15.3/devel:languages:php.repo
zypper -n --gpg-auto-import-keys refresh
zypper in -n nginx php8 php8-bcmath php8-devel php8-dom php8-fpm composer php8-opcache php8-mbstring php8-fileinfo php8-curl php8-mysql php8-soap php8-shmop php8-tidy php8-intl php8-gd php8-gettext php8-gmp install make findutils 

printf "\n" | pecl install apcu
echo "extension = apcu.so" > /etc/php8/conf.d/apcu.ini

cd /etc/php8/fpm
cp php-fpm.conf.default php-fpm.conf
cd php-fpm.d/
cp www.conf.default www.conf

systemctl start php-fpm.service
systemctl enable php-fpm.service

#Maria DB Installation
rpm --import https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
#zypper -n addrepo --gpgcheck --refresh https://yum.mariadb.org/10.5/opensuse/15/x86_64 mariadb
zypper -n --gpg-auto-import-keys refresh
#no silent install there is some output and the etc/my.cnf need to be changed
zypper -n in mariadb mariadb-client
#in case version changes ecc ecc just zypper search -s mariadb to get the latest
zypper in MariaDB-server MariaDB-rocksdb-engine MariaDB-oqgraph-engine MariaDB-columnstore-engine MariaDB-connect-engine

zypper -n in MariaDB-backup 
#this is used to load the timezone info (mysql_tz_info)
zypper -n in mariadb-tools

#binlog and where to find
mkdir /srv/binlog/binlog -p
chown mysql /srv/binlog

#per motivi MISTICI non è presente come default di usare jemalloc, e questo ha causato problemi 
#sopratutto se usi rocksdb...
zypper -n in jemalloc
echo 'Environment="LD_PRELOAD=/usr/lib64/libjemalloc.so.2"' >> /usr/lib/systemd/system/mariadb.service

#also change in case of warning / failure to start
vi /usr/lib/systemd/system/mariadb.service
> ProtectHome=false
> LimitNOFILE=50000

systemctl daemon-reload

#those are just a few common thing
echo "plugin-load-add=ha_connect" >> /etc/my.cnf.d/server.cnf
echo "plugin-load-add=ha_rocksdb.so" >> /etc/my.cnf.d/server.cnf
echo "rocksdb_flush_log_at_trx_commit = 2" >> /etc/my.cnf.d/server.cnf
echo "event_scheduler=ON"  >> /etc/my.cnf.d/server.cnf
#each server is different, take example from the various config file in gogs


systemctl start mariadb
systemctl enable mariadb

#in case you are doing an update also execute
# mysql_upgrade 

# in case ia a fresh install do 
# mysql_install_db 
# and change the privileges afterwards of the created stuff

#verificare sia usato jemalloc tramite 
#lsof -p $(pidof mysqld) | grep "jemalloc"
#SHOW VARIABLES LIKE 'version_malloc_library';
zypper in mariadb-tools

CREATE ALWAYS BOTH! You have no idea which one php will decide to use!!!

CREATE USER 'diter'@'localhost' IDENTIFIED BY 'asdf';
GRANT ALL PRIVILEGES ON *.* TO 'diter'@'localhost'  WITH GRANT OPTION;
flush privileges;


CREATE USER 'diter'@'127.0.0.1' IDENTIFIED BY 'asdf';
GRANT ALL PRIVILEGES ON *.* TO 'diter'@'127.0.0.1'  WITH GRANT OPTION;
flush privileges;
