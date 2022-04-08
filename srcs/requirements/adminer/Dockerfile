FROM debian:buster
RUN apt-get update && apt-get upgrade -y
RUN apt-get install wget apache2 php libapache2-mod-php php-curl php-cli php-mysql php-gd -y
RUN wget "http://www.adminer.org/latest.php" -O /var/www/html/index.php
RUN wget https://raw.github.com/vrana/adminer/master/designs/hever/adminer.css -O /var/www/html/adminer.css
CMD ["php", "-S", "0.0.0.0:80", "-t", "/var/www/html"]
