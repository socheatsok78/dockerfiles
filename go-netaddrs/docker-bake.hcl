target "go-netaddrs" {
  inherits = [ "dockerfiles" ]
  context = "go-netaddrs"
  tags = [
    tag("go-netaddrs", "latest"),
    tag_by_date("go-netaddrs")
  ]
}
