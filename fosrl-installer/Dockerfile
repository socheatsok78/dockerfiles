ARG GO_VERSION=1.24
ARG PANGOLIN_VERSION=1.16.2

FROM --platform=$BUILDPLATFORM golang:${GO_VERSION}-alpine AS build
RUN apk add --no-cache curl jq
ARG PANGOLIN_VERSION
ADD https://github.com/fosrl/pangolin.git#${PANGOLIN_VERSION}:install /fosrl-installer
WORKDIR /fosrl-installer
RUN --mount=type=cache,sharing=locked,id=fosrl-installer/go/pkg/mod,target=/go/pkg/mod,sharing=locked \
    --mount=type=cache,sharing=locked,id=fosrl-installer/root/.cache/go-build,target=/root/.cache/go-build \
<<EOF
    GERBIL_VERSION=$(curl -s https://api.github.com/repos/fosrl/gerbil/tags | jq -r '.[0].name')
    BADGER_VERSION=$(curl -s https://api.github.com/repos/fosrl/badger/tags | jq -r '.[0].name')
    GOLDFLAGS="-X main.pangolinVersion=${PANGOLIN_VERSION} -X main.gerbilVersion=${GERBIL_VERSION} -X main.badgerVersion=${BADGER_VERSION}"
    go build -ldflags "${GOLDFLAGS}" -o /usr/bin/fosrl-installer .
EOF

FROM alpine:3
RUN apk add --no-cache bash curl
COPY --from=build --link /usr/bin/fosrl-installer /usr/bin/fosrl-installer
ENTRYPOINT ["/usr/bin/fosrl-installer"]
