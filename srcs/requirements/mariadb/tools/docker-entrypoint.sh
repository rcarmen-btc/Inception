#!/bin/bash

if [ ! -f /var/lib/mysql/wpbasecreate${MYSQL_SETUP_VER}.zcris ]
then
service mysql start
echo "~> Waiting for confirmation of Mariadb service startup"
RET=1
while [[ RET -ne 0 ]]; do
    echo "...wait for database..."
    sleep 5
    mysql -uroot -h localhost -e "status" 2>dev/null
    RET=$?
done
echo "~> Started!"
set -e
mysql -u root -h localhost -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}"
mysql -u root -h localhost -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'"
mysql -u root -h localhost -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%'"
mysql -u root -h localhost -e "FLUSH PRIVILEGES"
mysqladmin -u root password ${MYSQL_ROOT_PASSWORD}

touch /var/lib/mysql/wpbasecreate${MYSQL_SETUP_VER}.zcris

service mysql stop
fi

exec mysqld_safe