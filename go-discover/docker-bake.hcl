target "go-discover" {
  inherits = [ "dockerfiles" ]
  context = "go-discover"
  tags = concat(
    tags("go-discover", "latest"),
    tag_by_date("go-discover"),
  )
}
