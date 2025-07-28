ARG GH_VERSION=2.76.1

# https://github.com/cli/cli
FROM alpine:latest AS gh
ARG GH_VERSION
ARG TARGETARCH
ARG TARGETVARIANT
ADD https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_${TARGETARCH}${TARGETVARIANT}.tar.gz /tmp/gh.tar.gz
WORKDIR /tmp/gh
RUN <<EOT
  tar -xzf /tmp/gh.tar.gz -C /tmp/gh --strip-components=1
  rm /tmp/gh/LICENSE
EOT
FROM scratch
COPY --from=gh --link /tmp/gh /
