target "openssl-dhparam" {
  inherits = [ "dockerfiles" ]
  context = "openssl-dhparam"
  tags = concat(
    tags("openssl-dhparam", "latest"),
    tag_by_date("openssl-dhparam"),
  )
}
