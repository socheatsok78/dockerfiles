ARG GITHUB_RUN_ID=0

FROM --platform=$BUILDPLATFORM alpine:latest AS libmaxminddb
RUN apk add --no-cache libmaxminddb
ENV MAXMINDDB_FILES="GeoLite2-ASN.mmdb GeoLite2-City.mmdb GeoLite2-Country.mmdb"
RUN --mount=type=secret,id=MAXMINDDB_USER_ID,env=MAXMINDDB_USER_ID \
    --mount=type=secret,id=MAXMINDDB_LICENSE_KEY,env=MAXMINDDB_LICENSE_KEY \
    echo "" > /etc/libmaxminddb.cron.conf && /etc/periodic/weekly/libmaxminddb

FROM --platform=$BUILDPLATFORM scratch AS geolite2-asn
ARG GITHUB_RUN_ID
COPY --from=libmaxminddb --link /var/lib/libmaxminddb/GeoLite2-ASN.mmdb /

FROM --platform=$BUILDPLATFORM scratch AS geolite2-city
ARG GITHUB_RUN_ID
COPY --from=libmaxminddb --link /var/lib/libmaxminddb/GeoLite2-City.mmdb /

FROM --platform=$BUILDPLATFORM scratch AS geolite2-country
ARG GITHUB_RUN_ID
COPY --from=libmaxminddb --link /var/lib/libmaxminddb/GeoLite2-Country.mmdb /
