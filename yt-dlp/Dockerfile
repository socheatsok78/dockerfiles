FROM alpine:3
RUN apk add --no-cache attr
RUN apk add --no-cache ca-certificates
RUN apk add --no-cache ffmpeg
RUN apk add --no-cache py3-brotli py3-mutagen py3-pycryptodomex py3-secretstorage py3-websockets
RUN apk add --no-cache yt-dlp
ENTRYPOINT ["yt-dlp"]
