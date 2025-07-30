ARG GO_VERSION=1.23.0

FROM --platform=$BUILDPLATFORM golang:${GO_VERSION}-alpine AS build
ADD https://github.com/socheatsok78/go-discover.git#master /go-discover
WORKDIR /go-discover/cmd/discover
RUN go build -ldflags "-w -s" -o /usr/local/bin/discover . \
    && chmod u+s /usr/local/bin/discover

FROM scratch
COPY --from=build --link /usr/local/bin/discover /usr/local/bin/discover
