#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
# or first arg is `something.conf`
if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
	set -- redis-server "$@"
fi

echo -e "\033[32m[INFO]\033[0m eg: docker run redis_images /usr/local/bin/redis.conf --requirepass password"
exec "$@"
