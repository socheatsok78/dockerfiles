# syntax=docker/dockerfile:1
ARG NIX_VERSION=latest

ARG GOLANG_IMAGE=golang:1.21.1-alpine@sha256:96634e55b363cb93d39f78fb18aa64abc7f96d372c176660d7b8b6118939d97b
ARG NIX_IMAGE=nixos/nix:${NIX_VERSION}

FROM scratch AS buildkit-nix
ADD https://github.com/reproducible-containers/buildkit-nix.git /

FROM --platform=${BUILDPLATFORM} ${GOLANG_IMAGE} AS build
WORKDIR /src
ENV CGO_ENABLED=0
ARG TARGETOS
ARG TARGETARCH
RUN --mount=from=buildkit-nix,target=. --mount=target=/root/.cache,type=cache --mount=target=/go/pkg,type=cache \
  GOOS=$TARGETOS GOARCH=$TARGETARCH go build -trimpath -ldflags "-s -w" -o /out/buildkit-nix-llb ./cmd/buildkit-nix

FROM scratch
COPY --from=build /out/ /
ARG NIX_IMAGE
ENV NIX_IMAGE=${NIX_IMAGE}
LABEL moby.buildkit.frontend.network.none="true"
ENTRYPOINT ["/buildkit-nix-llb", "frontend"]
