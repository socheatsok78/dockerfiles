# syntax=docker/dockerfile:1
ARG NIX_VERSION=2.32.8
FROM nixos/nix:${NIX_VERSION}
RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
