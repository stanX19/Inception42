#!/bin/bash



# create directory to use in nginx container later and also to setup the wordpress conf
mkdir /var/www/
mkdir /var/www/html

cd /var/www/html


rm -rf *

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 

chmod +x wp-cli.phar 

mv wp-cli.phar /usr/local/bin/wp


wp core download --allow-root

mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

mv /wp-config.php /var/www/html/wp-config.php


sed -i -r "s/db1/$db_name/1"   wp-config.php
sed -i -r "s/user/$db_user/1"  wp-config.php
sed -i -r "s/pwd/$db_pwd/1"    wp-config.php

# Wait for MariaDB to start up and listen on port 3306
until bash -c 'cat < /dev/null > /dev/tcp/mariadb/3306' 2>/dev/null; do
    echo "Waiting for MariaDB..."
    sleep 3
done

wp core install --url=$DOMAIN_NAME/ --title=$WP_TITLE --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root




wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root


wp theme install astra --activate --allow-root


wp plugin install redis-cache --activate --allow-root

wp plugin update --all --allow-root


 
sed -i 's/listen = \/run\/php\/php.*-fpm.sock/listen = 9000/g' /etc/php/*/fpm/pool.d/www.conf

mkdir /run/php

wp redis enable --allow-root

/usr/sbin/php-fpm* -F