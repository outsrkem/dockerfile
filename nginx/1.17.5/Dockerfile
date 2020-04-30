FROM hub.c.163.com/library/centos:7.4.1708
MAINTAINER <author@126.com>
LABEL version="nginx-1.17.5"
RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo && \
	yum -y install gcc* pcre pcre-devel perl perl-devel openssl openssl-devel && yum clean all

ADD ./nginx-1.17.5.tar.gz /root/

RUN useradd -r -s /sbin/nologin nginx && \
	cd /root/nginx-1.17.5 && \
	./configure --user=nginx --group=nginx \
	--prefix=/usr/local/nginx \
	--with-http_stub_status_module \
	--with-http_ssl_module && make && make install && \
	cd /root && rm -rf /root/nginx-1.17.5

RUN 

ENV PATH=/usr/local/nginx/sbin:$PATH \
	NGINX_HOME=/usr/local/nginx \
	NGINX_VERSION=1.17.5


EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]