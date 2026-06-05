ARG GO_VERSION=1.25
ARG COREDNS_VERSION=v1.14.3

FROM golang:${GO_VERSION}-alpine AS build
RUN apk add --no-cache git make

ARG COREDNS_VERSION
RUN git clone --depth 1 --branch ${COREDNS_VERSION} https://github.com/coredns/coredns.git /coredns
WORKDIR /coredns

ARG COREDNS_PLUGINS=
ENV COREDNS_PLUGINS=${COREDNS_PLUGINS}
RUN --mount=type=cache,sharing=locked,id=coredns-go,target=/go/pkg/mod \
    --mount=type=tmpfs,target=/root/.cache/go-build \
<<EOT
set -ex
export GOFLAGS="-buildvcs=false"
export COREDNS_PLUGINS="gslb:github.com/dmachard/coredns-gslb${COREDNS_PLUGINS:+,}$COREDNS_PLUGINS"
make gen
go mod edit -replace github.com/dmachard/coredns-gslb=github.com/socheatsok78/coredns-gslb-plugin@main
go mod tidy
make
EOT

FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /coredns/coredns /coredns
USER nonroot:nonroot
# Reset the working directory inherited from the base image back to the expected default:
# https://github.com/coredns/coredns/issues/7009#issuecomment-3124851608
WORKDIR /
EXPOSE 53 53/udp
ENTRYPOINT ["/coredns"]
