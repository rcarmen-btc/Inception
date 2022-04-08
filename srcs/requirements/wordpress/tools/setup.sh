#!/bin/sh

RED="31"
GREEN="32"
BOLDGREEN="\e[1;${GREEN}m"
ITALICRED="\e[3;${RED}m"
ENDCOLOR="\e[0m"

cd ${WORDPRESS_ROOT}

if [ ! -f "wp-config.php" ] ; then
	wp core download --locale=ru_RU 2> /dev/null
fi

connected=0
while [[ $connected -eq 0 ]] ; do
	mariadb -h${WORDPRESS_DB_HOST} -u${MYSQL_USER} -p${MYSQL_PASSWORD} &> /dev/null
	[[ $? -eq 0 ]] && { connected=$(( $connected + 1 )); }
	sleep 1
done

if [ ! -f "wp-config.php" ] ; then
	wp config create --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD} --dbhost=${WORDPRESS_DB_HOST}
fi

wp core install --url=${DOMAIN_NAME} --title="ЪУЪ" --admin_user=${WORDPRESS_DB_ADMIN} --admin_password=${WORDPRESS_DB_ADMIN_PASSWORD} --admin_email="${WORDPRESS_DB_ADMIN}@42.fr" --skip-email

wp user create ${WORDPRESS_DB_USER} "${WORDPRESS_DB_USER}@student.42.fr" --user_pass=${WORDPRESS_DB_USER_PASSWORD} --role=subscriber

wp theme install zakra --activate

wp post create ../../button.txt --post_title="Смысл жизни" --post_status=publish --path='/home/wordpress/'

wp post delete 1 --force

sed -i "s|<?php|<?php\ndefine( 'WP_REDIS_HOST', 'redis-cache' );|" wp-config.php
wp plugin install redis-cache --activate --allow-root
wp plugin update --all --allow-root

echo "listen = ${WORDPRESS_PORT}" >> /etc/php7/php-fpm.d/www.conf

echo -e "${BOLDGREEN}NICENICENICENICENICENICENICENICENICENICENICENICE${ENDCOLOR}"
echo "START PHP-FPM"
php-fpm7 -F