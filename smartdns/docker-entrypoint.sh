#!/bin/sh
set -e
#---------------------------

SMARTDNS_CONF=/etc/smartdns/smartdns.conf
SMARTDNS_BIN=/usr/bin/smartdns

function __log_info() {
    local log_time=`date "+[%F %T %z]"`
    echo -e "\033[32m${log_time} [I]\033[0m $@"
}

#----------main-------------------
cat <<-'EOF'

Example:
    docker run -d --net=host --restart=always --name=smartdns \
    -v /opt/smartdns/smartdns.conf:/etc/smartdns/smartdns.conf \
    -v /etc/localtime:/etc/localtime:ro smartdns

EOF

# -----------log----------------
__log_info "version `$SMARTDNS_BIN -v`"


__log_info "start smartdns."
exec "$@"

