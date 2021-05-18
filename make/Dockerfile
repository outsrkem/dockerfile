FROM  registry.cn-shanghai.aliyuncs.com/outsrkem/alpine:3.13.5 as compile
RUN echo 'https://dl-cdn.alpinelinux.org/alpine/v3.13/main' > /etc/apk/repositories
RUN echo 'https://dl-cdn.alpinelinux.org/alpine/v3.13/community' >> /etc/apk/repositories

RUN apk add gcc g++ make libffi-dev openssl-dev libtool
