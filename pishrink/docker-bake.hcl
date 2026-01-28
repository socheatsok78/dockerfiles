target "pishrink" {
  inherits = [ "dockerfiles" ]
  context = "https://github.com/Drewsif/PiShrink.git"
  tags = [
    tag("pishrink", "latest"),
    tag_by_date("pishrink")
  ]
}
