FROM alpine:3

COPY --from=hairyhenderson/gomplate:stable /gomplate /bin/gomplate
RUN apk add --no-cache ca-certificates

ENTRYPOINT ["/bin/gomplate"]
CMD ["--help"]
