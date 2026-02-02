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
  tags = concat(
    tags("db-ip", db),
    tag_by_date_with_prefix("db-ip", db),
  )
}
