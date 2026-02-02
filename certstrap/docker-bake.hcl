variable "CERTSTRAP_VERSION" {
  default = "1.3.0"
}

target "certstrap" {
  inherits = [ "dockerfiles" ]
  context = "https://github.com/square/certstrap.git#v${CERTSTRAP_VERSION}"
  tags = concat(
    tags("certstrap", "${CERTSTRAP_VERSION}"),
  )
}
