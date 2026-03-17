FROM golang:bookworm AS snmp_exporter
RUN apt-get update \
  && apt-get install -y --no-install-recommends libsnmp-dev unzip
ARG SNMP_EXPORTER_VERSION
ADD --keep-git-dir https://github.com/prometheus/snmp_exporter.git#${SNMP_EXPORTER_VERSION} /src
WORKDIR /src/generator

FROM snmp_exporter AS mibs
RUN make mibs

FROM snmp_exporter AS builder
RUN make generator

FROM debian:bookworm-slim
ENV MIBDIRS=/opt/mibs
COPY --from=mibs /src/generator/mibs ${MIBDIRS}
RUN apt-get update \
  && apt-get install -y --no-install-recommends libsnmp40 \
  && rm -rf /var/lib/apt/lists/*
WORKDIR "/tmp"
COPY --from=builder /src/generator/generator /bin/generator
ENTRYPOINT ["/bin/generator"]
CMD ["generate"]
