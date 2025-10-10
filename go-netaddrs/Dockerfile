ARG GO_VERSION=1.19

FROM --platform=$BUILDPLATFORM golang:${GO_VERSION}-alpine AS build
ADD https://github.com/socheatsok78/go-netaddrs.git#main /go-netaddrs
WORKDIR /go-netaddrs/cmd/netaddrs
RUN --mount=type=bind,target=/tmp/source \
    --mount=type=cache,sharing=locked,id=go-discover/go/pkg/mod,target=/go/pkg/mod,sharing=locked \
    --mount=type=cache,sharing=locked,id=go-netaddrs/root/.cache/go-build,target=/root/.cache/go-build \
<<EOT
  set -xeou pipefail
  for GOOS in linux; do
    for GOARCH in amd64 arm64; do
      export GOOS GOARCH
      go build -ldflags "-w -s" -o /usr/local/bin/netaddrs-${GOOS}-${GOARCH} .
    done
  done
EOT

FROM --platform=$BUILDPLATFORM scratch AS bin
ARG TARGETARCH
COPY --link --from=build /usr/local/bin/netaddrs-linux-${TARGETARCH} /usr/local/bin/netaddrs

FROM scratch
COPY --from=bin --link /usr/local/bin/netaddrs /usr/local/bin/netaddrs
