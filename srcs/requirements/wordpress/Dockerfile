FROM alpine:3.13

RUN	apk add \
	php7 \
	php7-fpm \
	php7-phar \
	php7-json \
	php7-curl \
	php7-mysqli \
	mariadb-client \
	php7-iconv \
	redis

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/bin/wp

COPY tools/button.txt .

COPY tools/setup.sh .

COPY tools/zakra /home/wordpress/zakra

ENTRYPOINT	["sh", "setup.sh"]
