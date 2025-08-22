ARG GO_VERSION=1.23.0

FROM --platform=$BUILDPLATFORM golang:${GO_VERSION}-alpine AS build
ADD https://github.com/socheatsok78/go-discover.git#master /go-discover
WORKDIR /go-discover/cmd/discover
RUN --mount=type=bind,target=/tmp/source \
    --mount=type=cache,sharing=locked,id=go-discover/go/pkg/mod,target=/go/pkg/mod,sharing=locked \
    --mount=type=cache,sharing=locked,id=go-discover/root/.cache/go-build,target=/root/.cache/go-build \
<<EOT
  set -xeou pipefail
  go build -ldflags "-w -s" -o /usr/local/bin/discover .
  chmod u+s /usr/local/bin/discover
EOT

FROM scratch
COPY --from=build --link /usr/local/bin/discover /usr/local/bin/discover
