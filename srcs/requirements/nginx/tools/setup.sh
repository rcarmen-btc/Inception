#!/bin/sh
RED="31"
GREEN="32"
BOLDGREEN="\e[1;${GREEN}m"
ITALICRED="\e[3;${RED}m"
ENDCOLOR="\e[0m"

mkdir -p /run/nginx && chown nginx:nginx /run/nginx

envsubst '${WORDPRESS_ROOT} ${WORDPRESS_HOST} ${WORDPRESS_PORT} ${DOMAIN_NAME} ${CERT_PATH} ${CERT_KEY_PATH}' < /etc/nginx/conf.d/default.conf.tmp >  /etc/nginx/conf.d/default.conf

echo -e "${BOLDGREEN}NICENICENICENICENICENICENICENICENICENICENICENICE${ENDCOLOR}"
nginx -g "daemon off;"
