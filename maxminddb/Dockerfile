FROM --platform=$BUILDPLATFORM alpine:latest AS download
RUN apk add --no-cache libmaxminddb
ENV MAXMINDDB_FILES="GeoLite2-ASN.mmdb GeoLite2-City.mmdb GeoLite2-Country.mmdb"
RUN --mount=type=secret,id=MAXMINDDB_USER_ID,env=MAXMINDDB_USER_ID \
    --mount=type=secret,id=MAXMINDDB_LICENSE_KEY,env=MAXMINDDB_LICENSE_KEY \
    echo "" > /etc/libmaxminddb.cron.conf && /etc/periodic/weekly/libmaxminddb

FROM --platform=$BUILDPLATFORM scratch AS geolite2-asn
COPY --from=download --link /var/lib/libmaxminddb/GeoLite2-ASN.mmdb /

FROM --platform=$BUILDPLATFORM scratch AS geolite2-city
COPY --from=download --link /var/lib/libmaxminddb/GeoLite2-City.mmdb /

FROM --platform=$BUILDPLATFORM scratch AS geolite2-country
COPY --from=download --link /var/lib/libmaxminddb/GeoLite2-Country.mmdb /

FROM --platform=$BUILDPLATFORM scratch AS latest
COPY --from=geolite2-asn --link /var/lib/libmaxminddb/GeoLite2-ASN.mmdb /
COPY --from=geolite2-city --link /var/lib/libmaxminddb/GeoLite2-City.mmdb /
COPY --from=geolite2-country --link /var/lib/libmaxminddb/GeoLite2-Country.mmdb /
