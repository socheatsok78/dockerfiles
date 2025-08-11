ARG GITHUB_RUN_ID=0

FROM --platform=$BUILDPLATFORM alpine:latest AS libmaxminddb
RUN apk add --no-cache libmaxminddb

FROM --platform=$BUILDPLATFORM libmaxminddb AS db-geolite2-asn
ENV MAXMINDDB_FILES="GeoLite2-ASN.mmdb"
RUN --mount=type=secret,id=MAXMINDDB_USER_ID,env=MAXMINDDB_USER_ID \
    --mount=type=secret,id=MAXMINDDB_LICENSE_KEY,env=MAXMINDDB_LICENSE_KEY \
    echo "" > /etc/libmaxminddb.cron.conf && /etc/periodic/weekly/libmaxminddb

FROM --platform=$BUILDPLATFORM libmaxminddb AS db-geolite2-city
ENV MAXMINDDB_FILES="GeoLite2-City.mmdb"
RUN --mount=type=secret,id=MAXMINDDB_USER_ID,env=MAXMINDDB_USER_ID \
    --mount=type=secret,id=MAXMINDDB_LICENSE_KEY,env=MAXMINDDB_LICENSE_KEY \
    echo "" > /etc/libmaxminddb.cron.conf && /etc/periodic/weekly/libmaxminddb

FROM --platform=$BUILDPLATFORM libmaxminddb AS db-geolite2-country
ENV MAXMINDDB_FILES="GeoLite2-Country.mmdb"
RUN --mount=type=secret,id=MAXMINDDB_USER_ID,env=MAXMINDDB_USER_ID \
    --mount=type=secret,id=MAXMINDDB_LICENSE_KEY,env=MAXMINDDB_LICENSE_KEY \
    echo "" > /etc/libmaxminddb.cron.conf && /etc/periodic/weekly/libmaxminddb

FROM scratch AS geolite2-asn
ARG GITHUB_RUN_ID
COPY --from=db-geolite2-asn --link /var/lib/libmaxminddb/GeoLite2-ASN.mmdb /

FROM scratch AS geolite2-city
ARG GITHUB_RUN_ID
COPY --from=db-geolite2-city --link /var/lib/libmaxminddb/GeoLite2-City.mmdb /

FROM scratch AS geolite2-country
ARG GITHUB_RUN_ID
COPY --from=db-geolite2-country --link /var/lib/libmaxminddb/GeoLite2-Country.mmdb /
