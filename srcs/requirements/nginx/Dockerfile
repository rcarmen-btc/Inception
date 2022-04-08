FROM alpine:3.13

RUN	apk update && \
	apk upgrade && \
	apk add --update \
	openssl \
	nginx \
	gettext && \
	mkdir -p /etc/nginx/certificates && \
	openssl req \
		-x509 \
		-newkey rsa:2048 \
		-keyout /etc/nginx/certificates/key.pem \
		-out /etc/nginx/certificates/cert.pem \
		-days 365 \
		-nodes \
		-subj /CN=rcarmen.42.fr

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY conf/conf.d /etc/nginx/conf.d

COPY tools/setup.sh .

EXPOSE 443
	
ENTRYPOINT 	["sh"]

CMD ["setup.sh"]
