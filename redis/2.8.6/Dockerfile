FROM hub.c.163.com/library/centos:7.4.1708 as compile

RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo
RUN yum -y install gcc gcc-c++ pcre pcre-devel perl perl-devel openssl openssl-devel

ADD ./redis-3.0.5.tar.gz /root

WORKDIR /root/redis-3.0.5
RUN make -j 
RUN make -j PREFIX=/usr/local/redis install 
RUN mkdir /usr/local/redis/conf 
RUN cp ./redis.conf /usr/local/redis/conf

COPY ./docker-entrypoint.sh /usr/local/redis/bin/entrypoint.sh
#
#
# build
FROM hub.c.163.com/library/centos:7.4.1708 as build
COPY --from=0 /usr/local/redis /usr/local/redis

RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
  useradd  -u 1200 -ms /bin/bash redis && \
  chown 1200.1200 -R /usr/local/redis && \
  echo "export PS1='(redis)[\u@\h \W]\\$ '" >> /etc/bashrc

USER redis

ENV PATH=/usr/local/redis/bin:$PATH \
    REDIS_MAJOR=2.8 \
    REDIS_MAJOR_VERSION=2.8.6 \
    REDIS_CONF=/usr/local/redis/conf/redis.conf

WORKDIR /usr/local/redis

ENTRYPOINT ["entrypoint.sh"]

CMD ["redis-server", "/usr/local/redis/conf/redis.conf"]
