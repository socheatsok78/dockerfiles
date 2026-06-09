# syntax=docker/dockerfile:1
ARG COREDNS_VERSION
ARG GO_VERSION=1.25

FROM golang:${GO_VERSION}-alpine AS build
RUN apk add --no-cache git make

ARG COREDNS_VERSION
RUN git clone --depth 1 --branch "v${COREDNS_VERSION}" https://github.com/coredns/coredns.git /coredns
WORKDIR /coredns

ARG GITHUB_REPOSITORY_OWNER=
ARG COREDNS_PLUGINS=
RUN --mount=type=bind,target=/tmp/source \
    --mount=type=cache,sharing=locked,id=coredns-go,target=/go/pkg/mod \
    --mount=type=tmpfs,target=/root/.cache/go-build \
<<EOT
set -ex
export GOFLAGS="-buildvcs=false"
export COREDNS_PLUGINS="$(tr '\n' ',' < "/tmp/source/plugins.cfg")${COREDNS_PLUGINS}"
make gen
xargs -a "/tmp/source/replace.txt" -I {} go mod edit --replace {}
go mod tidy
export GITCOMMIT="$(git describe --dirty --always)-${GITHUB_REPOSITORY_OWNER}"
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
