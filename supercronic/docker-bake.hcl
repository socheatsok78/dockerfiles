group "supercronic" {
  targets = [
    "supercronic-basic",
    "supercronic-docker",
  ]
}

target "supercronic-basic" {
  inherits = [ "dockerfiles" ]
  context = "supercronic"
  tags = concat(
    tags("supercronic", "latest"),
  )
}

target "supercronic-docker" {
  inherits = [ "dockerfiles" ]
  context = "supercronic"
  tags = concat(
    tags("supercronic", "docker"),
  )
}
