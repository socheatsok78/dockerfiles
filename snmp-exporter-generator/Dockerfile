FROM golang:bookworm AS snmp_exporter
RUN apt-get update \
  && apt-get install -y --no-install-recommends libsnmp-dev unzip
ARG SNMP_EXPORTER_VERSION
ADD --keep-git-dir https://github.com/prometheus/snmp_exporter.git#${SNMP_EXPORTER_VERSION} /src
WORKDIR /src/generator
RUN make generator

FROM debian:bookworm-slim
ENV MIBDIRS=/opt/mibs
ADD --link https://github.com/socheatsok78-lab/snmp_exporter_mibs.git#main:mibs ${MIBDIRS}
RUN apt-get update \
  && apt-get install -y --no-install-recommends libsnmp40 \
  && rm -rf /var/lib/apt/lists/*
WORKDIR "/tmp"
COPY --from=snmp_exporter /src/generator/generator /bin/generator
ENTRYPOINT ["/bin/generator"]
CMD ["generate"]
