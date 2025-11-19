FROM hub.c.163.com/library/centos:7.4.1708
LABEL version="centos:7.4.1708-jdk17.0.2"

ADD jdk-17.0.2_linux-x64_bin.tar.gz /opt

RUN groupadd -g 2000 server &&\
	useradd -u 2000 -g  2000 server &&\
	rm -rf /root/*

ENV JAVA_HOME=/opt/jdk-17.0.2 \
    CLASSPATH=.:/opt/jdk-17.0.2/lib \
    PATH=/opt/jdk-17.0.2/bin:$PATH

