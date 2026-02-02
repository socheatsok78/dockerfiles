target "socat" {
  inherits = [ "dockerfiles" ]
  context = "socat"
  tags = [
    tag("socat", "latest"),
  ]
}
