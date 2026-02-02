target "go-discover-dockerswarm" {
  inherits = [ "dockerfiles" ]
  context = "go-discover-dockerswarm"
  tags = concat(
    tags("go-discover-dockerswarm", "latest"),
    tag_by_date("go-discover-dockerswarm"),
  )
}
