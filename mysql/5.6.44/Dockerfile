FROM hub.c.163.com/library/centos:7.4.1708

RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	useradd -r -s /sbin/nologin mysql && \
	mkdir /docker-entrypoint-initdb.d && \
	curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo && \
	yum -y install autoconf libaio libaio-devel numactl.x86_64 && yum clean all && \
	rm -rf /tmp/* && rm -rf /root/* && rm -rf /anaconda-post.log


# 注意要保证MySQL解压之后的目录是mysql
ADD ./mysql-5.6.44-linux-glibc2.12-x86_64.tar.gz /usr/local/

ENV PATH=/usr/local/mysql/bin:$PATH \
	MYSQL_MAJOR=5.6 \
	MYSQL_VERSION=5.6.44

WORKDIR /usr/local/mysql

COPY ./my.cnf /etc/my.cnf

# 注意确保文件docker-entrypoint.sh 有执行权限。
COPY docker-entrypoint.sh /bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
CMD ["mysqld"]