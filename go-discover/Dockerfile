# syntax=docker/dockerfile:1
ARG GO_VERSION=1.25.7

FROM --platform=$BUILDPLATFORM golang:${GO_VERSION}-alpine AS build
ADD  https://github.com/socheatsok78-lab/go-discover.git#go-netaddrs-v1.3.0 /go-discover
WORKDIR /go-discover/cmd/discover
RUN --mount=type=cache,sharing=locked,id=go-discover/go/pkg/mod,target=/go/pkg/mod \
    --mount=type=tmpfs,target=/root/.cache/go-build \
<<EOT
  set -xeou pipefail
  for GOOS in linux; do
    for GOARCH in amd64 arm64; do
      export GOOS GOARCH
      go build -ldflags "-w -s" -o /usr/local/bin/discover-${GOOS}-${GOARCH} .
    done
  done
EOT

FROM --platform=$BUILDPLATFORM scratch AS bin
ARG TARGETARCH
COPY --link --from=build /usr/local/bin/discover-linux-${TARGETARCH} /usr/local/bin/discover

FROM scratch
COPY --from=bin --link /usr/local/bin/discover /usr/local/bin/discover
