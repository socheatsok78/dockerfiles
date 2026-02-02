
variable "CADDY_VERSION" {
  type = list(string)
  default = [
    "2.10.2",
  ]
}

target "caddy-layer4" {
  inherits = [ "dockerfiles" ]
  matrix = {
    version = CADDY_VERSION
  }
  name = "caddy-l4-${replace(version, ".", "-")}"
  description = "Caddy with TCP/UDP support"
  context = "caddy-layer4"
  args = {
    CADDY_VERSION = version
    CADDY_TARGET = "layer4"
  }
  tags = concat(
    tags("caddy-l4", version),
    tag_by_date("caddy-l4"),
  )
}
