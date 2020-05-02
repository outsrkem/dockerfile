FROM hub.c.163.com/library/centos:7.4.1708

ADD ./redis2.8.6.tar.gz /usr/local/

RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	rm -rf /tmp/* && rm -rf /root/* 


ENV PATH=/usr/local/redis/bin:$PATH \
	REDIS_MAJOR=2.8 \
	REDIS_MAJOR_VERSION=2.8.6 \
	REDIS_CONF=/usr/local/redis/etc/redis.conf


WORKDIR /usr/local/redis


COPY docker-entrypoint.sh /bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

CMD ["redis-server", "/usr/local/redis/etc/redis.conf"]