#!/bin/bash
#In theory this file should be called like 
#wget it or git clone the repo, and than call this .sh file. from it the script will start to handle all the stuff that is needed.
#Check that this is beeing executed with elevated privileges, for the moment the error will make clear it should be
#The objective is to have the ability to SERVE PHP WEBPAGES, using nginx, using php-fpm WITH a php user that has SUDO priviledge
#this data MUST be served ONLY on 127.0.0.1 interface! 
#use as a reference https://github.com/dublinbranch/serverConfig/blob/master/php8
#https://github.com/dublinbranch/serverConfig/blob/master/nginx.sh
#also create the basic db and stuff to initialize the software after

zypper -n in nginx php8 php8-bcmath php8-devel php8-dom php8-fpm composer php8-opcache php8-mbstring php8-fileinfo php8-curl php8-mysql php8-soap php8-shmop php8-tidy php8-intl php8-gd php8-gettext php8-gmp make findutils 

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

 #'EOF' will not interpret variables
cat << EOF > /etc/nginx/php
location ~ \.php$ {
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    fastcgi_pass 127.0.0.1:9000;
}
index index.php;
EOF


cat << EOF > /etc/nginx/disableSendingSensitiveInfo
location ~ /\.git {
    deny all;
}
location ~ \.sh {
    deny all;
}
EOF


cat << EOF > /etc/nginx/staticCache
location ~* \.(js|css|png|jpg|jpeg|gif|ico)$ {
    expires 1h;
    log_not_found off;
}
EOF


#ovewrite default nginx, 'EOF' will not interpret variables
#very important as those will allow many many concurrent connection !
cat << 'EOF' > /etc/nginx/nginx.conf
worker_processes  1;
worker_rlimit_nofile 100000;

events {
    worker_connections  100000;
    use epoll;
}

http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format postdata escape=json '$remote_addr - $remote_user [$time_local] '
                       '"$request" $status $bytes_sent '
                       '"$http_referer" "$http_user_agent" "$request_body"';

    #access_log  /var/log/nginx/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    gzip  on;
    gzip_types
        text/plain
        text/css
        text/js
        text/xml
        text/javascript
        application/javascript
        application/json
        application/xml
        application/rss+xml
        image/svg+xml;

    include conf.d/*.conf;
    server {
        #listen ...
    
    }

     server {
        listen :80;
        server_name _;
        root /srv/www/diter;
        include /etc/nginx/php;
        access_log /var/log/nginx/diter.log postdata;
        error_log /var/log/nginx/diter.err;
        
        client_max_body_size 20M;

	location / {
            try_files $uri $uri/ /index.php?$args;
            index  index.html index.htm index.php;
        }

	location ~ \.php$ {
            try_files $uri =404;
            fastcgi_pass   127.0.0.1:9000;
            fastcgi_index  index.php;
            fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
            include        fastcgi_params;
        }
    }

    include vhosts.d/*.conf;
}
#location /wUAPbqwJSBYu2KEgPmxkyZAbtF6IAz7 {
#    stub_status on;
#    access_log   off;
#}


EOF

#Insert Script Folder
mkdir /srv/www/diter/
chown wwwrun:www /srv/www/diter/
chmod 755 /srv/www/diter/
wget https://raw.githubusercontent.com/mihaldisike/DiTeR/main/demo/index.php -O /srv/www/diter/index.php
chown wwwrun:www /srv/www/diter/index.php
chmod 644 /srv/www/diter/index.php
echo move to next commands - Test Server
