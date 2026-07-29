# syntax=docker/dockerfile:1
ARG NIX_VERSION=latest
FROM nixos/nix:${NIX_VERSION}
COPY <<EOT /etc/nix/nix.docker.conf
# This file is used to configure Nix when running inside a Docker container.
filter-syscalls = false
experimental-features = configurable-impure-env nix-command flakes
EOT
RUN echo "!include /etc/nix/nix.docker.conf" >> /etc/nix/nix.conf
