FROM golang:bookworm AS builder

RUN apt-get update \
  && apt-get install -y --no-install-recommends libsnmp-dev unzip

ARG SNMP_EXPORTER_VERSION
ADD https://github.com/prometheus/snmp_exporter.git#v${SNMP_EXPORTER_VERSION} /src
WORKDIR /src/generator
RUN make generator mibs

FROM debian:bookworm-slim

ENV MIBDIRS=/opt/mibs
COPY --from=builder /src/generator/mibs ${MIBDIRS}

RUN apt-get update \
  && apt-get install -y --no-install-recommends libsnmp40 \
  && rm -rf /var/lib/apt/lists/*

WORKDIR "/opt/generator"
COPY --from=builder /src/generator/generator /bin/generator
ENTRYPOINT ["/bin/generator"]
CMD ["generate"]
