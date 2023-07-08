#!/bin/bash
set -e

[ -d /etc/nginx/cert ] || mkdir /etc/nginx/cert

cd /etc/nginx/cert && openssl req -newkey rsa:2048 -nodes -sha256 -x509 -days 3650 \
-subj /CN=nginx.org \
-keyout ./cert.key  -out ./cert.pem

set -- /usr/sbin/nginx -g "daemon off;"
exec "$@"
