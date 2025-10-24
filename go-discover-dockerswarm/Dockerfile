ARG GO_VERSION=1.23.8

FROM --platform=$BUILDPLATFORM golang:${GO_VERSION}-alpine AS build
ADD https://github.com/socheatsok78/go-discover-dockerswarm.git#main /go-discover-dockerswarm
WORKDIR /go-discover-dockerswarm/cmd
RUN --mount=type=cache,sharing=locked,id=go-discover/go/pkg/mod,target=/go/pkg/mod,sharing=locked \
    --mount=type=cache,sharing=locked,id=go-discover-dockerswarm/root/.cache/go-build,target=/root/.cache/go-build \
<<EOT
  set -xeou pipefail
  for GOOS in linux; do
    for GOARCH in amd64 arm64; do
      export GOOS GOARCH
      go build -ldflags "-w -s" -o /usr/local/bin/discover-dockerswarm-${GOOS}-${GOARCH} .
      chmod u+s /usr/local/bin/discover-dockerswarm-${GOOS}-${GOARCH}
    done
  done
EOT

FROM --platform=$BUILDPLATFORM scratch AS bin
ARG TARGETARCH
COPY --link --from=build /usr/local/bin/discover-dockerswarm-linux-${TARGETARCH} /usr/local/bin/discover-dockerswarm

FROM scratch
COPY --from=bin --link /usr/local/bin/discover-dockerswarm /usr/local/bin/discover-dockerswarm
