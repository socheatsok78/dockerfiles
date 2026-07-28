# syntax=docker/dockerfile:1
ARG NIX_VERSION=latest
FROM nixos/nix:${NIX_VERSION}
RUN echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf
