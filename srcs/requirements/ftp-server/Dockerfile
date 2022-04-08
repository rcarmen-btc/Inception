FROM alpine:3.15
RUN apk update && apk upgrade
RUN apk add vsftpd openssl
COPY ./conf/etc /etc
COPY ./tools/docker-entrypoint.sh ./
RUN mkdir -p /var/www/html
ENTRYPOINT ["sh", "./docker-entrypoint.sh"]