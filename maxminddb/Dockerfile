FROM --platform=$BUILDPLATFORM alpine:latest AS libmaxminddb
RUN apk add --no-cache libmaxminddb
ARG MAXMINDDB_FILES
RUN --mount=type=secret,id=MAXMINDDB_USER_ID,env=MAXMINDDB_USER_ID \
    --mount=type=secret,id=MAXMINDDB_LICENSE_KEY,env=MAXMINDDB_LICENSE_KEY \
    echo "" > /etc/libmaxminddb.cron.conf && \
    /etc/periodic/weekly/libmaxminddb

FROM --platform=$BUILDPLATFORM scratch AS geolite2-asn
ENV MAXMINDDB_FILES=GeoLite2-ASN
COPY --from=libmaxminddb /var/lib/libmaxminddb/${MAXMINDDB_FILES} /

FROM --platform=$BUILDPLATFORM scratch AS geolite2-city
ENV MAXMINDDB_FILES=GeoLite2-City
COPY --from=libmaxminddb /var/lib/libmaxminddb/${MAXMINDDB_FILES} /

FROM --platform=$BUILDPLATFORM scratch AS geolite2-country
ENV MAXMINDDB_FILES=GeoLite2-Country
COPY --from=libmaxminddb /var/lib/libmaxminddb/${MAXMINDDB_FILES} /
