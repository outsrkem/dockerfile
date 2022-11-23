#!/bin/bash
set -e

cd /usr/local/nginx/cert && openssl req -newkey rsa:2048 -nodes -sha256 -x509 -days 3650 \
-subj /CN=nginx.org \
-keyout ./cert.key  -out ./cert.pem

set -- /usr/local/nginx/sbin/nginx -g "daemon off;"
exec "$@"