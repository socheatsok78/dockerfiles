variable "COREDNS_VERSION" {
  type = list(string)
  default = [
    "1.14.3",
  ]
}

target "coredns" {
  inherits = [ "dockerfiles" ]
  matrix = {
    version = COREDNS_VERSION
  }
  name = "coredns-${replace(version, ".", "-")}"
  context = "coredns"
  args = {
    COREDNS_VERSION = version
  }
  tags = concat(
    tags("coredns", version),
    tag_by_date("coredns"),
  )
}
