target "go-discover" {
  inherits = [ "dockerfiles" ]
  context = "go-discover"
  tags = [
    tag("go-discover", "latest"),
    tag_by_date("go-discover")
  ]
}
