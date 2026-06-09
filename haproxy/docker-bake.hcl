variable "HAPROXY_VERSION" {
  type = list(string)
  default = [
    "3.4.0",
  ]
}

variable "HAPROXY_DATAPLANEAPI_VERSION" {
  default = "3.3.5"
}

target "haproxy" {
  inherits = [ "dockerfiles" ]
  matrix = {
    version = HAPROXY_VERSION
  }
  name = "haproxy_${sanitize(version)}"
  context = "haproxy"
  args = {
    HAPROXY_VERSION = version
    HAPROXY_DATAPLANEAPI_VERSION = HAPROXY_DATAPLANEAPI_VERSION
  }
  tags = concat(
    tags("haproxy", version),
    tag_by_date("haproxy"),
  )
}
