# syntax=docker/dockerfile:1
ARG HAPROXY_VERSION=3.3
ARG HAPROXY_DATAPLANEAPI_VERSION=3.2.7

FROM haproxy:${HAPROXY_VERSION}-alpine
USER 0:0
RUN apk add -uU bash git
ARG HAPROXY_DATAPLANEAPI_VERSION
ADD --unpack=true https://github.com/haproxytech/dataplaneapi/releases/download/v${HAPROXY_DATAPLANEAPI_VERSION}/dataplaneapi_${HAPROXY_DATAPLANEAPI_VERSION}_linux_x86_64.tar.gz /opt/dataplaneapi
