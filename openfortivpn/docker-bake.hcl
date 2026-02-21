target "openfortivpn" {
  inherits = [ "dockerfiles" ]
  context = "openfortivpn"
  tags = concat(
    tags("openfortivpn", "latest"),
  )
}
