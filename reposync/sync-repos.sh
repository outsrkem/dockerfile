#!/bin/bash
workspace=$(cd `dirname $0`; pwd)
cd $workspace

function _log_info() {
  echo -e "`date "+[%F %T %z]"`\033[32m[I]\033[0m $@"
  echo -e "`date "+[%F %T %z]"`[I] $@" >> task.log
}


function check_network(){
    local targets=("www.baidu.com" "www.huawei.com" "www.sina.com.cn" "nginx.org")
    for target in ${targets[@]};do
        curl --location --connect-timeout 3 -o /dev/null -s -w "%{http_code}" "${target}" &>/dev/null
        if [ $? -eq 0 ]; then
            return 1
        fi
    done
    _log_info "ckeck url ${target}"
    return 0
}

# main
_log_info "+++++++++++++++++++++++++++++++++++++++"

check_network
if [ $? -eq 0 ];then
        _log_info "If the network is abnormal, exit task."
        exit 100
fi

_log_info "create yum makecache"

yum clean all
yum makecache
yum repolist

for i in `seq 10`;do echo -n "$i ";sleep 1;done; echo 

_log_info "The system starts source synchronization"

reposync -p /opt/mirrors/centos/7/x86_64

sleep 1
_log_info "start update createrepo"
#createrepo --update /opt/mirror/centos/7/x86_64/base
#createrepo --update /opt/mirror/centos/7/x86_64/extras
#createrepo --update /opt/mirror/centos/7/x86_64/updates
#createrepo --update /opt/mirror/centos/7/x86_64/docker-ce-stable
#createrepo --update /opt/mirror/centos/7/x86_64/epel
#createrepo --update /opt/mirror/centos/7/x86_64/nginx

for i in `ls /opt/mirrors/centos/7/x86_64`;do
    _log_info "createrepo $i"
    createrepo --update /opt/mirrors/centos/7/x86_64/$i
done

_log_info "sync successfully."
