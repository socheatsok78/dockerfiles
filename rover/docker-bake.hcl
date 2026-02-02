target "rover" {
  inherits = [ "dockerfiles" ]
  context = "rover"
  tags = concat(
    tags("rover", "latest"),
    tag_by_date("rover"),
  )
}
