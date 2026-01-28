target "openssl-dhparam" {
  inherits = [ "dockerfiles" ]
  context = "openssl-dhparam"
  tags = [
    tag("openssl-dhparam", "latest"),
    tag_by_date("openssl-dhparam")
  ]
}
