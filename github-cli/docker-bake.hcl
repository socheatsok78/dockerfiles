target "github-cli" {
  inherits = [ "dockerfiles" ]
  context = "github-cli"
  tags = concat(
    tags("github-cli", "latest"),
    tag_by_date("github-cli"),
  )
}
