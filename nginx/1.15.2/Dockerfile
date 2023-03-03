FROM hub.c.163.com/library/centos:7.4.1708 as compile
LABEL version="nginx-1.15.2"
RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.163.com/.help/CentOS7-Base-163.repo && \
    yum -y install gcc gcc-c++ pcre pcre-devel perl perl-devel openssl openssl-devel

ADD ./nginx-1.15.2.tar.gz /root

RUN useradd -r -s /sbin/nologin nginx && \
    cd /root/nginx-1.15.2 && \
    ./configure --user=nginx --group=nginx \
    --prefix=/usr/local/nginx \
    --pid-path=/usr/local/nginx/run/nginx.pid \
    --with-http_stub_status_module \
    --with-http_ssl_module && \
    make -j && make install -j

FROM hub.c.163.com/library/centos:7.4.1708 as build
COPY --from=0 /usr/local/nginx /usr/local/nginx
# --from=0 是指第一个构建阶段
# addgroup -S nginx && adduser -S nginx -G nginx
RUN ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    useradd -r -s /sbin/nologin nginx && \
    echo "export PS1='(nginx)[\u@\h \W]\\$ '" >> /etc/bashrc

WORKDIR /usr/local/nginx

ENV PATH=/usr/local/nginx/sbin:$PATH \
    NGINX_HOME=/usr/local/nginx \
    NGINX_VERSION=1.15.2

CMD ["nginx", "-g", "daemon off;"]
