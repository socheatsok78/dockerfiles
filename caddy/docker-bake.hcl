
variable "CADDY_VERSION" {
  type = list(string)
  default = [
    "2.10.2",
  ]
}

target "caddy" {
  inherits = [ "dockerfiles" ]
  matrix = {
    version = CADDY_VERSION
  }
  name = "caddy-${replace(version, ".", "-")}"
  context = "caddy"
  args = {
    CADDY_BUILDER_VERSION = regex("^(\\d+\\.\\d+)", version)[0]
    CADDY_VERSION = version
    CADDY_TARGET = "caddy"
  }
  tags = [
    tag("caddy", version),
    tag_by_date("caddy")
  ]
}
