FROM centos:7.6.1810 as compile

RUN rpm -Uvh  http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo

RUN yum install --downloadonly --downloaddir=/tmp/package \
	vim wget curl bzip2 unzip tcpdump bash-completion dos2unix psmisc \
	tcpdump less telnet net-tools lsof sysstat python-setuptools lrzsz ntpdate bind-utils openssl \
	nginx-1.24.0



##########################
FROM centos:7.6.1810 as build
RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime
COPY --from=0 /tmp/package /tmp/package
RUN yum -y localinstall /tmp/package/*.rpm
RUN rm -rf /root/anaconda-ks.cfg /tmp/* /etc/yum.repos.d/*


RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

USER root

COPY docker-entrypoint.sh /bin/entrypoint.sh
COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80/tcp 443/tcp

ENV NGINX_VERSION=1.24.0

WORKDIR /root
ENTRYPOINT ["entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
