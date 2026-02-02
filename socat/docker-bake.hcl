target "socat" {
  inherits = [ "dockerfiles" ]
  context = "socat"
  tags = concat(
    tags("socat", "latest"),
  )
}
