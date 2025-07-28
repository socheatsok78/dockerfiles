FROM --platform=$BUILDPLATFORM alpine:latest AS libmaxminddb
RUN apk add --no-cache libmaxminddb

FROM --platform=$BUILDPLATFORM libmaxminddb AS libmaxminddb-geolite2-asn
ENV MAXMINDDB_FILES=GeoLite2-ASN.mmdb
RUN --mount=type=secret,id=MAXMINDDB_USER_ID,env=MAXMINDDB_USER_ID \
    --mount=type=secret,id=MAXMINDDB_LICENSE_KEY,env=MAXMINDDB_LICENSE_KEY \
    echo "" > /etc/libmaxminddb.cron.conf && /etc/periodic/weekly/libmaxminddb

FROM --platform=$BUILDPLATFORM libmaxminddb AS libmaxminddb-geolite2-city
ENV MAXMINDDB_FILES=GeoLite2-City.mmdb
RUN --mount=type=secret,id=MAXMINDDB_USER_ID,env=MAXMINDDB_USER_ID \
    --mount=type=secret,id=MAXMINDDB_LICENSE_KEY,env=MAXMINDDB_LICENSE_KEY \
    echo "" > /etc/libmaxminddb.cron.conf && /etc/periodic/weekly/libmaxminddb

FROM --platform=$BUILDPLATFORM libmaxminddb AS libmaxminddb-geolite2-country
ENV MAXMINDDB_FILES=GeoLite2-Country.mmdb
RUN --mount=type=secret,id=MAXMINDDB_USER_ID,env=MAXMINDDB_USER_ID \
    --mount=type=secret,id=MAXMINDDB_LICENSE_KEY,env=MAXMINDDB_LICENSE_KEY \
    echo "" > /etc/libmaxminddb.cron.conf && /etc/periodic/weekly/libmaxminddb

FROM --platform=$BUILDPLATFORM scratch AS geolite2-asn
COPY --from=libmaxminddb-geolite2-asn /var/lib/libmaxminddb/GeoLite2-ASN.mmdb /

FROM --platform=$BUILDPLATFORM scratch AS geolite2-city
COPY --from=libmaxminddb-geolite2-city /var/lib/libmaxminddb/GeoLite2-City.mmdb /

FROM --platform=$BUILDPLATFORM scratch AS geolite2-country
COPY --from=libmaxminddb-geolite2-country /var/lib/libmaxminddb/GeoLite2-Country.mmdb /

FROM --platform=$BUILDPLATFORM scratch AS latest
COPY --from=libmaxminddb-geolite2-asn /var/lib/libmaxminddb/GeoLite2-ASN.mmdb /
COPY --from=libmaxminddb-geolite2-city /var/lib/libmaxminddb/GeoLite2-City.mmdb /
COPY --from=libmaxminddb-geolite2-country /var/lib/libmaxminddb/GeoLite2-Country.mmdb /
