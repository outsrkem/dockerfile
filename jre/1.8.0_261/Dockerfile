FROM hub.c.163.com/library/centos:7.4.1708
LABEL version="centos:7.4.1708-jre1.8.261"

ADD jre-8u261-linux-x64.tar.gz /opt

RUN groupadd -g 2000 server &&\
	useradd -u 2000 -g  2000 server &&\
	rm -rf /root/*

ENV JAVA_HOME=/opt/jre1.8.0_261 \
    CLASSPATH=.:/opt/jre1.8.0_261/lib/rt.jar:/opt/jre1.8.0_261/lib \
    PATH=/opt/jre1.8.0_261/bin:$PATH

