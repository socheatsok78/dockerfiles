ARG HAPROXY_VERSION=3.3
FROM haproxy:${HAPROXY_VERSION}-alpine
USER 0:0
RUN apk add -uU bash git
ADD https://github.com/haproxytech/dataplaneapi/releases/download/v3.2.7/dataplaneapi_3.2.7_linux_x86_64.tar.gz /tmp/dataplaneapi.tar.gz
RUN mkdir -p /opt/dataplaneapi \
    && tar -zxvf /tmp/dataplaneapi.tar.gz -C /opt/dataplaneapi \
    && rm /tmp/dataplaneapi.tar.gz
