FROM hub.c.163.com/library/centos:7.4.1708

ADD ./package/redis2.8.6.tar.gz /usr/local/

COPY docker-entrypoint.sh /bin/entrypoint.sh

RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
  useradd  -u 1200 -ms /bin/bash redis && \
  chown 1200.1200 /bin/entrypoint.sh && \
  chown 1200.1200 -R /usr/local/redis && \
  rm -rf /tmp/* && rm -rf /root/*

USER redis

ENV PATH=/usr/local/redis/bin:$PATH \
	REDIS_MAJOR=2.8 \
	REDIS_MAJOR_VERSION=2.8.6 \
	REDIS_CONF=/usr/local/redis/etc/redis.conf

WORKDIR /usr/local/redis

ENTRYPOINT ["entrypoint.sh"]

CMD ["redis-server", "/usr/local/redis/etc/redis.conf"]
