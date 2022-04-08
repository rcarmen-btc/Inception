include srcs/.env
export $(shell sed 's/=.*//' srcs/.env)

DC = docker-compose -f srcs/docker-compose.yml 
SHELL := /bin/bash

buildup:
	$(DC) up -d --build

up:
	$(DC) up -d

prep: 
	echo "127.0.0.1 ${DOMAIN_NAME}" | sudo tee -a /etc/hosts
	cat /etc/hosts
	sudo mkdir -p ${MARIADB_VOLUME_PATH} ${WORDPRESS_VOLUME_PATH}

rmprep:
	sudo sed -i "/127.0.0.1 ${DOMAIN_NAME}/d" /etc/hosts
	sudo rm -rf ${MARIADB_VOLUME_PATH} ${WORDPRESS_VOLUME_PATH}

logs:
	$(DC) logs

stop:
	$(DC) stop

dstop:
	@if [ "$$(docker ps -q)" == "" ] ; then \
		echo "No containers is running";\
	else \
		docker stop $$(docker ps -qa); \
	fi

rm:
	@if [ "$$(docker ps -a -q)" == "" ] ; then \
		echo "No containers";\
	else \
		docker rm $$(docker ps -a -q); \
	fi

rmi:
	@if [ "$$(docker images -a -q)" == "" ] ; then \
		echo "No images";\
	else \
		docker rmi -f $$(docker images -a -q); \
	fi

rmv:
	@if [ "$$(docker volume ls -q)" == "" ] ; then \
		echo "No volumes";\
	else \
		docker volume rm $$(docker volume ls -q); \
	fi

rmn:
	@if [ "$$(docker network ls -q)" == "" ] ; then \
		echo "No networks";\
	else \
		docker network rm $$(docker network ls -q) 2>/dev/null; \
	fi

ps:
	docker ps
	cd srcs && docker-compose ps

reup: stop up

re: stop rm rmv buildup
