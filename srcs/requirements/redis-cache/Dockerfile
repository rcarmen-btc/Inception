FROM alpine:3.15
RUN apk update && apk upgrade
RUN apk add redis
COPY ./conf/etc /etc
COPY ./tools/docker-entrypoint.sh ./
ENTRYPOINT ["sh", "./docker-entrypoint.sh"]