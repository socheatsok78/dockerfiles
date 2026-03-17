variable "SNMP_EXPORTER_VERSION" {
  default = "0.30.1"
}

group "snmp-exporter-generator" {
  targets = [
    "snmp-exporter-generator-main",
    "snmp-exporter-generator-tagged",
  ]
}

target "snmp-exporter-generator-main" {
  inherits = [ "dockerfiles" ]
  context = "snmp-exporter-generator"
  args = {
    "SNMP_EXPORTER_VERSION" = "main"
  }
  tags = concat(
    tags("snmp-exporter-generator", "main"),
  )
}

target "snmp-exporter-generator-tagged" {
  inherits = [ "dockerfiles" ]
  context = "snmp-exporter-generator"
  args = {
    "SNMP_EXPORTER_VERSION" = "v${SNMP_EXPORTER_VERSION}"
  }
  tags = concat(
    tags("snmp-exporter-generator", SNMP_EXPORTER_VERSION),
  )
}
