FROM debian:buster
RUN apt-get update && apt-get upgrade -y
RUN apt-get install apache2 -y
COPY ./tools /var/www/html/
COPY ./conf /etc
RUN chown -R www-data. /var/www/html
CMD ["apachectl", "-D", "FOREGROUND"]
