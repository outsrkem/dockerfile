FROM hub.c.163.com/library/centos:7.4.1708


RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	useradd -r -s /sbin/nologin redis && \
	mkdir /docker-entrypoint-initdb.d && \
	curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo && \
	yum -y install ----------- && \
	rm -rf /tmp/* && rm -rf /root/* 



RUN cd redis-2.8.6 && \
	make && \
	make PREFIX=/usr/local/redis install && \
	mkdir /usr/local/redis/conf && \
	cp ./redis.conf /usr/local/redis/conf && \



ENV PATH=/usr/local/redis/bin:$PATH \
	REDIS_MAJOR=2.8 \
	REDIS_MAJOR_VERSION=2.8.6


WORKDIR /usr/local/redis

COPY ./my.cnf /etc/my.cnf

# 注意确保文件docker-entrypoint.sh 有执行权限。
COPY docker-entrypoint.sh /bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["mysqld"]