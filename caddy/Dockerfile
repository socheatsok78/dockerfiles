ARG CADDY_BUILDER_VERSION=2
ARG CADDY_VERSION=2
ARG CADDY_TARGET=caddy

FROM caddy:${CADDY_BUILDER_VERSION}-builder-alpine AS build
WORKDIR /tmp/source
ARG CADDY_VERSION
ARG CADDY_TARGET
RUN --mount=type=bind,target=/tmp/source \
    --mount=type=cache,sharing=locked,id=${CADDY_TARGET}/go/pkg/mod,target=/go/pkg/mod,sharing=locked \
    --mount=type=tmpfs,target=/root/.cache/go-build \
<<EOT
  set -xeou pipefail
  test -f "${CADDY_TARGET}/modules.txt" || exit 1
  xcaddy build v${CADDY_VERSION} --output /usr/bin/caddy $(xargs -a "${CADDY_TARGET}/modules.txt" -I {} echo --with {}) $(test -f "${CADDY_TARGET}/replace.txt" && xargs -a "${CADDY_TARGET}/replace.txt" -I {} echo --replace {})
  /usr/bin/caddy list-modules
EOT

FROM caddy:${CADDY_VERSION}-alpine
RUN apk add -Uu --no-cache ca-certificates
COPY --link --from=build /usr/bin/caddy /usr/bin/caddy
