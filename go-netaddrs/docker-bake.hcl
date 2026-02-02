target "go-netaddrs" {
  inherits = [ "dockerfiles" ]
  context = "go-netaddrs"
  tags = concat(
    tags("go-netaddrs", "latest"),
    tag_by_date("go-netaddrs"),
  )
}
