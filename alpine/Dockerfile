FROM scratch
ADD alpine-minirootfs-3.13.5-x86_64.tar.gz /
RUN apk add --no-cache -U tzdata && ln -fs ../usr/share/zoneinfo/Asia/Shanghai /etc/localtime