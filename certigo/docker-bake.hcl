variable "CERTIGO_VERSION" {
  default = "1.17.1"
}

target "certigo" {
  inherits = [ "dockerfiles" ]
  context = "certigo"
  args = {
    CERTIGO_VERSION = "${CERTIGO_VERSION}"
  }
  tags = [
    tag("certigo", "${CERTIGO_VERSION}"),
  ]
}
