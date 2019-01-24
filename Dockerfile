FROM alpine:latest
ENV CONF_FILE /config/dnscrypt-proxy.toml
RUN apk add --no-cache wget ca-certificates \
    && wget -q https://github.com/jedisct1/dnscrypt-proxy/releases/download/2.0.19/dnscrypt-proxy-linux_arm-2.0.19.tar.gz \
    && tar -xzf dnscrypt-proxy-linux_arm-2.0.19.tar.gz \
    && mv /linux-arm /dnscrypt
EXPOSE 53/tcp 53/udp
VOLUME ["/config"]
CMD /dnscrypt/dnscrypt-proxy -syslog -config $CONF_FILE
