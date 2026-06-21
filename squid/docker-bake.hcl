target "squid" {
  inherits = [ "dockerfiles" ]
  context = "squid"
  tags = concat(
    tags("squid", "latest"),
  )
}
