# syntax=docker/dockerfile:1
FROM alpine:3
RUN apk add --no-cache tini
ARG TARGETARCH
ADD https://github.com/aptible/supercronic/releases/download/v0.2.49/supercronic-linux-${TARGETARCH} /usr/local/bin/supercronic
RUN chmod +x /usr/local/bin/supercronic
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/supercronic"]
CMD [ "--help" ]
