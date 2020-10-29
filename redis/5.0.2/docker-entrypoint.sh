#!/bin/bash
set -e

if [ "${1:0:1}" == "" ]; then
	if [ -n "$REDIS_DB_PORT" -a "$REDIS_DB_PORT" != "6379" ];then
		sed -i "s/port 6379/port ${REDIS_DB_PORT}/g" ${REDIS_CONF:-/usr/local/redis/conf/redis.conf}
	fi
	set -- redis-server ${REDIS_CONF:-/usr/local/redis/conf/redis.conf}
fi

exec "$@"

