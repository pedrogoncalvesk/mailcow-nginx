#!/bin/sh

envsubst < /etc/nginx/conf.d/templates/listen_plain.template > /etc/nginx/conf.d/listen_plain.active
envsubst < /etc/nginx/conf.d/templates/listen_ssl.template > /etc/nginx/conf.d/listen_ssl.active
envsubst < /etc/nginx/conf.d/templates/server_name.template > /etc/nginx/conf.d/server_name.active

nginx -t

until ping phpfpm -c1 > /dev/null; do sleep 1; done
until ping sogo -c1 > /dev/null; do sleep 1; done
until ping redis -c1 > /dev/null; do sleep 1; done

exec "$@"
