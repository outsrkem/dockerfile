#!/bin/bash
set -e

[ -d /etc/nginx/cert ] || mkdir /etc/nginx/cert

openssl req -newkey rsa:2048 -nodes -sha256 -x509 -days 3650 -subj /CN=nginx.org \
-keyout /etc/nginx/cert/cert.key  -out /etc/nginx/cert/cert.pem

exec "$@"
