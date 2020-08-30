FROM hub.c.163.com/library/centos:7.4.1708 as compile

RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo && \
    yum -y install git

ADD ./apache-maven-3.3.9-bin.tar.gz /root
ADD ./jdk-8u261-linux-x64.tar.gz /root

ENV JAVA_HOME /root/jdk1.8.0_261
ENV PATH $JAVA_HOME/bin:$PATH

ENV MAVEN_HOME /root/apache-maven-3.3.9
ENV PATH $MAVEN_HOME/bin:$PATH

WORKDIR /root
RUN git clone https://gitee.com/Outsrkem/zkweb.git

WORKDIR /root/zkweb
RUN mvn clean compile
RUN mvn clean package


FROM hub.c.163.com/library/centos:7.4.1708 as build
COPY --from=0 /root/zkweb/target/zkWeb-v1.2.1.war /opt

RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "export PS1='(zkweb)[\u@\h \W]\\$ '" >> /etc/bashrc

ADD ./jdk-8u261-linux-x64.tar.gz /usr/local/
ENV JAVA_HOME=/usr/local/jdk1.8.0_261 \
    PATH=/usr/local/jdk1.8.0_261/bin:$PATH

WORKDIR /opt

CMD ["java", "-jar", "zkWeb-v1.2.1.war"]
