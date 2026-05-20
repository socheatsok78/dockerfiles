target "xfr" {
  inherits = [ "dockerfiles" ]
  context = "xfr"
  tags = concat(
    tags("xfr", "latest"),
  )
}
