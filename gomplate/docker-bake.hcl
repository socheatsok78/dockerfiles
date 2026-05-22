target "gomplate" {
  inherits = [ "dockerfiles" ]
  context = "gomplate"
  tags = concat(
    tags("gomplate", "latest"),
  )
}
