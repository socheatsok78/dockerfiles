target "github-cli" {
  inherits = [ "dockerfiles" ]
  context = "github-cli"
  tags = [
    tag("github-cli", "latest"),
    tag_by_date("github-cli")
  ]
}
