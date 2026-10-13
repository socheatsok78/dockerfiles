target "supercronic" {
  inherits = [ "dockerfiles" ]
  context = "supercronic"
  tags = concat(
    tags("supercronic", "latest"),
  )
}
