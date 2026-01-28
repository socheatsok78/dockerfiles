target "db-ip" {
  inherits = [ "dockerfiles" ]
  matrix = {
    db = [
      "asn-lite",
      "city-lite",
      "country-lite",
    ]
  }
  name = "db-ip-${db}"
  context = "db-ip"
  target = db
  args = {
    DATE = formatdate("YYYY-MM", timestamp())
  }
  tags = [
    tag("db-ip", db),
  ]
}
