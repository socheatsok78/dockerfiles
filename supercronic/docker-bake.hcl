group "supercronic" {
  targets = [
  ]
}

target "supercronic-basic" {
  inherits = [ "dockerfiles" ]
  context = "supercronic"
  tags = concat(
    tags("supercronic", "latest"),
  )
}
