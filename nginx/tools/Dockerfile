FROM centos:7.6.1810 as compile

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


##########################
FROM centos:7.6.1810 as build
RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo && \
    yum install -y vim wget curl bzip2 unzip tcpdump bash-completion dos2unix psmisc \
    tcpdump less telnet net-tools lsof sysstat python-setuptools lrzsz ntpdate bind-utils openssl && \
    yum clean all && rm -rf /root/*


COPY --from=0 /usr/local/nginx /usr/local/nginx
RUN useradd -r -s /sbin/nologin nginx &&\
    mkdir /usr/local/nginx/cert &&\
    chown -R nginx.root /usr/local/nginx

USER nginx
RUN ln -s /dev/stdout /usr/local/nginx/logs/access.log
RUN ln -s /dev/stderr /usr/local/nginx/logs/error.log

USER root

COPY docker-entrypoint.sh /bin/entrypoint.sh
COPY nginx.conf /usr/local/nginx/conf/nginx.conf

ENV PATH=/usr/local/nginx/sbin:$PATH \
    NGINX_HOME=/usr/local/nginx \
    NGINX_VERSION=1.17.5

WORKDIR /root
ENTRYPOINT ["entrypoint.sh"]

