#!/bin/bash
set -e

if [ "$1" == 'redis-server' ]; then
	echo "------>  --env REDIS_PORT=3345   端口修改"

	if [ ! -z "$REDIS_PORT" ];then
		sed -i "s/port 6379/port ${REDIS_PORT}/g"  /usr/local/redis/etc/redis.conf
		echo
		echo "------>  redis 容器内新端口为 $REDIS_PORT "
		echo
	fi
fi

exec "$@"
