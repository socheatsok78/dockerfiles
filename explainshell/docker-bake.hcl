target "explainshell" {
  inherits = [ "dockerfiles" ]
  context = "https://github.com/idank/explainshell.git#cfa685e7ada2731bc188efeaa24a271845a15bb0"
  matrix = {
    "VERSION" = [ "latest" ]
  }
  tags = [
    tag("explainshell", VERSION),
    tag_by_date("explainshell")
  ]
}
