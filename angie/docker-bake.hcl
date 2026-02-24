target "angie" {
  inherits = [ "dockerfiles" ]
  context = "angie"
  tags = concat(
    tags("angie", "stable-alpine"),
  )
}
