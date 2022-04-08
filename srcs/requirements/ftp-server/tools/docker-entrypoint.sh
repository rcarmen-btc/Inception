#!/bin/sh

if [ ! -f /etc/ssl/certs/vsftpd.key ];
then
openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
	-out /etc/ssl/certs/vsftpd.pem -keyout /etc/ssl/certs/vsftpd.key \
	-subj "/C=RU/ST=Moscow/L=Moscow/O=inception/OU=zcris/CN=zcris" &> /dev/null
adduser ${FTP_USER} --disabled-password
echo "${FTP_USER}:${FTP_USER_PASSWORD}" | chpasswd &> /dev/null
chmod -R 777 /var/www/html
chmod -R 777 /home/wordpress
chown -R ${FTP_USER}:${FTP_USER} /var/www/html
chown -R ${FTP_USER}:${FTP_USER} /home
fi

echo "ftp inception start"
/usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
