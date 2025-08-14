ARG CADDY_VERSION=2

FROM caddy:${CADDY_VERSION}-builder-alpine AS build
WORKDIR /tmp/source
RUN --mount=type=bind,target=/tmp/source <<EOT
  set -xeou pipefail
  test -f modules.txt || exit 1
  xcaddy build --output /usr/bin/caddy $(xargs -a modules.txt -I {} echo --with {})
  /usr/bin/caddy list-modules
EOT

FROM caddy:${CADDY_VERSION}-alpine
RUN apk add -Uu --no-cache ca-certificates
COPY --link --from=build /usr/bin/caddy /usr/bin/caddy
