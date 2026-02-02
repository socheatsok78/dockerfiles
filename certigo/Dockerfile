ARG CERTIGO_VERSION
ARG GO_VERSION=1.25

FROM golang:${GO_VERSION}-alpine AS build
ARG CERTIGO_VERSION
ADD https://github.com/square/certigo.git#v${CERTIGO_VERSION} /certigo
WORKDIR /certigo
RUN --mount=type=cache,sharing=locked,id=certigo/go/pkg/mod,target=/go/pkg/mod,sharing=locked \
    --mount=type=cache,sharing=locked,id=certigo/root/.cache/go-build,target=/root/.cache/go-build \
    apk add --no-cache --virtual .build-deps bash && \
    ./build && \
    apk del .build-deps

FROM gcr.io/distroless/static
COPY --from=build /certigo/bin/certigo /usr/bin/certigo
ENTRYPOINT [ "/usr/bin/certigo" ]
