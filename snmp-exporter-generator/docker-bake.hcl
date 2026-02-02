variable "SNMP_EXPORTER_VERSION" {
  default = "0.30.1"
}

target "snmp-exporter-generator" {
  inherits = [ "dockerfiles" ]
  context = "snmp-exporter-generator"
  args = {
    "SNMP_EXPORTER_VERSION" = SNMP_EXPORTER_VERSION
  }
  tags = concat(
    tags("snmp-exporter-generator", SNMP_EXPORTER_VERSION),
  )
}
