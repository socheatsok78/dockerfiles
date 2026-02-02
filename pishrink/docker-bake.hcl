target "pishrink" {
  inherits = [ "dockerfiles" ]
  context = "https://github.com/Drewsif/PiShrink.git#0912020d6c3ac374b6617433a7769c6ed3fd4f1d"
  tags = concat(
    tags("pishrink", "latest"),
    tag_by_date("pishrink"),
  )
}
