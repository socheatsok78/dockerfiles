target "haproxy" {
  inherits = [ "dockerfiles" ]
  context = "haproxy"
  tags = concat(
    tags("haproxy", "latest"),
    tag_by_date("haproxy"),
  )
}
