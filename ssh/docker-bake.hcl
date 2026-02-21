target "ssh" {
  inherits = [ "dockerfiles" ]
  context = "ssh"
  tags = concat(
    tags("ssh", "latest"),
  )
}
