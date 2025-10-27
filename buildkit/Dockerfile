ARG BUILDKIT_VERSION
FROM moby/buildkit:${BUILDKIT_VERSION}
COPY --chmod=0755 run.sh /run.sh
ENTRYPOINT [ "/run.sh", "buildkitd" ]
