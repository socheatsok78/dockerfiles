target "haproxy" {
  inherits = [ "dockerfiles" ]
  context = "haproxy"
  tags = [
    tag("haproxy", "latest"),
    tag_by_date("haproxy")
  ]
}
