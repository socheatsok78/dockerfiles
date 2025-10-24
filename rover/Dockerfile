ARG ROVER_VERSION=main
ARG TF_VERSION=1.13.4
ARG GO_VERSION=1.21
ARG NODE_VERSION=20
ARG ALPINE_VERSION=3

FROM hashicorp/terraform:${TF_VERSION} AS terraform

FROM --platform=$BUILDPLATFORM alpine:${ALPINE_VERSION} AS stage0
ARG ROVER_VERSION
RUN <<EOT
    apk add --no-cache --virtual .build-deps curl git
    git clone --depth=1 --branch=${ROVER_VERSION} --single-branch https://github.com/im2nguyen/rover.git /rover
    apk del .build-deps
EOT

FROM --platform=$BUILDPLATFORM node:${NODE_VERSION}-alpine AS stage1
COPY --link --from=stage0 /rover /rover
WORKDIR /rover/ui
RUN --mount=type=cache,sharing=locked,target=/root/.npm \
<<EOT
  set -x
  npm set progress=false
  npm config set depth
  npm ci
  NODE_OPTIONS='--openssl-legacy-provider' npm run build
  rm -rf ./node_modules
EOT

FROM --platform=$BUILDPLATFORM golang:${GO_VERSION}-alpine AS stage2
# Copy the Vault source code from the previous stage
COPY --link --from=stage0 /rover /rover
COPY --link --from=stage1 /rover/ui/dist/ /rover/ui/dist/
WORKDIR /rover

RUN --mount=type=cache,sharing=locked,target=/go/pkg/mod \
  --mount=type=tmpfs,target=/root/.cache/go-build \
<<EOT
  GOLDFLAGS="-w -s"
  for GOARCH in amd64 arm64; do
      mkdir -p ./bin/linux_${GOARCH}
      (set -x; CGO_ENABLED=0 GOOS=linux GOARCH=${GOARCH} go build -o ./bin/linux_${GOARCH} -ldflags "${GOLDFLAGS}" .)
  done
  rm -rf /go/pkg/mod/*
  rm -rf /root/.cache/go-build/*
EOT

FROM alpine:${ALPINE_VERSION}
RUN apk add chromium tini

# Copy rover and terraform binaries
ARG TARGETARCH
COPY --link --from=terraform /bin/terraform /bin/terraform
COPY --link --from=stage2 /rover/bin/linux_${TARGETARCH}/rover /bin/rover

# Set working directory and entrypoint
WORKDIR /src
ENTRYPOINT [ "tini" ]
CMD [ "/bin/rover" ]
