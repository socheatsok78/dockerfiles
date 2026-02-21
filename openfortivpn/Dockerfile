FROM alpine:edge
# Add the testing repository to get the latest version of openfortivpn
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories
RUN apk --no-cache add openfortivpn
ENTRYPOINT ["/usr/bin/openfortivpn"]
