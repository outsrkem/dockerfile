# https://download.redis.io/releases/redis-5.0.2.tar.gz
# make -j
# make PREFIX=/usr/local/redis install
# mkdir -p /usr/local/redis/{conf/conf.d,data,log,run}
# cp ./redis.conf /usr/local/redis/conf

FROM hub.c.163.com/library/centos:7.4.1708

ADD ./redis.tar.gz /usr/local/
COPY ./docker-entrypoint.sh /bin/entrypoint.sh

#RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
#	useradd  -u 1200 -ms /bin/bash redis && \
#	curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo &&\
#	yum install -y vim wget curl bzip2 unzip tcpdump bash-completion dos2unix psmisc tcpdump less telnet net-tools lsof sysstat python-setuptools lrzsz ntpdate bind-utils &&\
#	rm -rf /tmp/* && rm -rf /root/* &&\
#	yum clean all


RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime &&\
	rm -rf /tmp/* && rm -rf /root/*

ENV PATH=/usr/local/redis/bin:$PATH \
	TMOUT=300 \
	REDIS_DOWNLOAD_URL=https://download.redis.io/releases/redis-5.0.2.tar.gz \
	REDIS_VERSION=5.0.2 \
	REDIS_CONF=/usr/local/redis/conf/redis.conf \
	REDIS_DB_PORT=6379

WORKDIR /usr/local/redis

ENTRYPOINT ["entrypoint.sh"]
