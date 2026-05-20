target "ttl" {
  inherits = [ "dockerfiles" ]
  context = "ttl"
  tags = concat(
    tags("ttl", "latest"),
  )
}
