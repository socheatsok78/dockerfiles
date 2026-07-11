target "git" {
  inherits = [ "dockerfiles" ]
  context = "git"
  tags = concat(
    tags("git", "latest"),
  )
}
