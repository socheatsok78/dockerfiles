target "coredns" {
  inherits = [ "dockerfiles" ]
  context = "coredns"
  tags = concat(
    tags("coredns", "latest"),
  )
}
