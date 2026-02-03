target "fosrl-installer" {
  inherits = [ "dockerfiles" ]
  context = "fosrl-installer"
  tags = concat(
    tags("fosrl-installer", "latest"),
  )
}
