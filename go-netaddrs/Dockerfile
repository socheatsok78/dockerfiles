ARG GO_VERSION=1.19

FROM --platform=$BUILDPLATFORM golang:${GO_VERSION}-alpine AS build
ADD https://github.com/socheatsok78/go-netaddrs.git#main /go-netaddrs
WORKDIR /go-netaddrs/cmd/netaddrs
RUN --mount=type=bind,target=/tmp/source \
    --mount=type=cache,sharing=locked,target=/go/pkg/mod \
    --mount=type=cache,sharing=locked,target=/root/.cache/go-build \
<<EOT
  set -xeou pipefail
  go build -ldflags "-w -s" -o /usr/local/bin/netaddrs .
  chmod u+s /usr/local/bin/netaddrs
EOT

FROM scratch
COPY --from=build --link /usr/local/bin/netaddrs /usr/local/bin/netaddrs
