
variable "CADDY_VERSION" {
  type = list(string)
  default = [
    "2.10.2",
  ]
}

target "caddy-json-schema" {
  inherits = [ "dockerfiles" ]
  matrix = {
    version = CADDY_VERSION
  }
  name = "caddy-json-schema-${replace(version, ".", "-")}"
  context = "caddy-json-schema"
  args = {
    CADDY_VERSION = version
    CADDY_TARGET = "json-schema"
  }
  tags = [
    tag("caddy-json-schema", version),
    tag_by_date("caddy-json-schema")
  ]
}
