FROM --platform=$BUILDPLATFORM alpine:latest AS builder
RUN apk add --no-cache openssl
RUN openssl dhparam -out /dhparam.pem 4096

FROM --platform=$BUILDPLATFORM scratch
COPY --from=builder /dhparam.pem /dhparam.pem
