## About

The Rust toolchain installer

## Usage

Install Rust toolchain with `debian` image as base:
```Dockerfile
FROM ghcr.io/socheatsok78/rustup-init:1.28.2 AS rustup-init

FROM debian:latest

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.86.0

RUN --mount=type=bind,from=rustup-init,source=/rustup-init,target=/usr/local/bin/rustup-init \
    set -ex; \
    /usr/local/bin/rustup-init -y --no-modify-path --profile minimal --default-toolchain ${RUST_VERSION}; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;
```

Install Rust toolchain with `alpine` image as base:
```Dockerfile
FROM ghcr.io/socheatsok78/rustup-init:1.28.2-musl AS rustup-init

FROM alpine:latest

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.86.0

RUN --mount=type=bind,from=rustup-init,source=/rustup-init,target=/usr/local/bin/rustup-init \
    set -ex; \
    /usr/local/bin/rustup-init -y --no-modify-path --profile minimal --default-toolchain ${RUST_VERSION}; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;
```
