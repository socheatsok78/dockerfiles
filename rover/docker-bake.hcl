target "rover" {
  inherits = [ "dockerfiles" ]
  context = "rover"
  tags = [
    tag("rover", "latest"),
    tag_by_date("rover")
  ]
}
