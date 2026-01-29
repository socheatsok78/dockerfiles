variable "SNMP_EXPORTER_VERSION" {
  default = "0.30.1"
}
target "snmp-exporter-generator" {
  inherits = [ "dockerfiles" ]
  context = "https://github.com/prometheus/snmp_exporter.git#v${SNMP_EXPORTER_VERSION}:generator"
  tags = [
    tag("snmp-exporter-generator", SNMP_EXPORTER_VERSION),
  ]
}
