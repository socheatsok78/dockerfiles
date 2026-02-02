target "figlet" {
  inherits = [ "dockerfiles" ]
  context = "figlet"
  tags = concat(
    tags("figlet", "latest"),
  )
}
