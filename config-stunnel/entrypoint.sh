#!/bin/sh
set -e
apk add envsubst
envsubst < /etc/stunnel/stunnel.template.conf > /etc/stunnel/stunnel.conf
exec /usr/bin/stunnel /etc/stunnel/stunnel.conf
