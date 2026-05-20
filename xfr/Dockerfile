FROM ghcr.io/socheatsok78/rustup-init:1.29.0-musl AS rustup-init

FROM alpine:3 AS builder

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH 

RUN --mount=type=bind,from=rustup-init,source=/rustup-init,target=/usr/local/bin/rustup-init \
    set -ex; \
    apk add --no-cache gcc musl-dev; \
    /usr/local/bin/rustup-init -y --no-modify-path --profile minimal --default-toolchain stable; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup update; \
    rustup --version; \
    cargo --version; \
    rustc --version;

ADD https://github.com/socheatsok78/xfr.git /src/xfr
WORKDIR /src/xfr
RUN cargo build --release

FROM alpine:3
RUN apk add --no-cache tini
COPY --from=builder /src/xfr/target/release/xfr /usr/local/bin/xfr
ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/xfr"]
