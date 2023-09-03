FROM alpine:3.18.0

COPY docker-entrypoint.sh /usr/bin/entrypoint.sh
COPY smartdns /usr/bin/smartdns
COPY smartdns.conf /etc/smartdns/smartdns.conf

ENTRYPOINT ["entrypoint.sh"]
CMD ["/usr/bin/smartdns","-fc","/etc/smartdns/smartdns.conf"]

