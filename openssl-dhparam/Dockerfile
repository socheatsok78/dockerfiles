FROM --platform=$BUILDPLATFORM alpine:latest AS builder
RUN apk add --no-cache openssl
ARG GITHUB_SHA=2e5199fca84ab505e09301329a4b3e81310c51d2
RUN openssl dhparam -out /dhparam.pem 4096

FROM --platform=$BUILDPLATFORM scratch
COPY --from=builder /dhparam.pem /dhparam.pem
