FROM --platform=$BUILDPLATFORM alpine:latest AS builder
RUN apk add --no-cache openssl
RUN openssl dhparam -out /dhparam.pem 4096

FROM --platform=$BUILDPLATFORM scratch
ARG GITHUB_RUN_ID=0
COPY --from=builder /dhparam.pem /dhparam.pem
