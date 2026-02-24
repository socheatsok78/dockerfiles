target "unzip" {
  inherits = [ "dockerfiles" ]
  context = "unzip"
  tags = concat(
    tags("unzip", "latest"),
  )
}
