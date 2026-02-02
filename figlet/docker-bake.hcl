target "figlet" {
  inherits = [ "dockerfiles" ]
  context = "figlet"
  tags = [
    tag("figlet", "latest"),
  ]
}
