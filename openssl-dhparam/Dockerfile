ARG GITHUB_SHA=

FROM --platform=$BUILDPLATFORM alpine:latest AS builder
ARG GITHUB_SHA
RUN apk add --no-cache openssl && openssl dhparam -out /dhparam.pem 4096

FROM --platform=$BUILDPLATFORM scratch
COPY --from=builder /dhparam.pem /dhparam.pem
