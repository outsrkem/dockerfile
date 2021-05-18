FROM  registry.cn-shanghai.aliyuncs.com/outsrkem/alpine:Make-4.3 as compile

ADD http://download.redis.io/releases/redis-6.2.1.tar.gz /root
RUN cd /root && tar xfv redis-6.2.1.tar.gz

WORKDIR /root/redis-6.2.1

RUN make -j
RUN make install

COPY ./docker-entrypoint.sh /usr/local/bin/entrypoint.sh
COPY ./redis.conf  /usr/local/bin/redis.conf

RUN chmod 750 /usr/local/bin/* 
RUN chmod 640 /usr/local/bin/redis.conf


FROM  registry.cn-shanghai.aliyuncs.com/outsrkem/alpine:3.13.5 as build
COPY --from=0 /usr/local/bin /usr/local/bin

ENV REDIS_DOWNLOAD_URL=http://download.redis.io/releases/redis-6.2.1.tar.gz
ENV REDIS_VERSION=6.2.1

WORKDIR /root
EXPOSE 6379

ENTRYPOINT ["entrypoint.sh"]
CMD ["redis-server","/usr/local/bin/redis.conf"]
