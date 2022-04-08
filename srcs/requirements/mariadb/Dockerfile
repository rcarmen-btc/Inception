FROM debian:buster
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y mariadb-server mariadb-client net-tools
COPY ./conf/etc /etc
COPY ./tools/docker-entrypoint.sh ./
ENTRYPOINT ["bash", "./docker-entrypoint.sh"]
