FROM hub.c.163.com/library/centos:7.4.1708

RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ADD ./nginx.tar.gz /usr/local/

RUN useradd -r -s /sbin/nologin nginx &&\
	chown nginx.nginx -R /usr/local/nginx &&\
	cd /root &&\
	rm -rf /root/* &&\
	rm -rf /tmp/*


ENV PATH=/usr/local/nginx/sbin:$PATH \
	NGINX_HOME=/usr/local/nginx \
	NGINX_CONF=/usr/local/nginx/conf \
	NGINX_CONF_stream=/usr/local/nginx/conf.d \
	NGINX_VERSION=1.15.2

WORKDIR /usr/local/nginx

CMD ["nginx"]

