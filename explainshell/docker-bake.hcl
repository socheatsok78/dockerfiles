target "idank-explainshell" {
  context = "https://github.com/idank/explainshell.git#cfa685e7ada2731bc188efeaa24a271845a15bb0"
}

target "explainshell" {
  inherits = [ "dockerfiles" ]
  context = "explainshell"
  matrix = {
    "VERSION" = [ "latest" ]
  }
  contexts = {
    "idank-explainshell" = "target:idank-explainshell"
  }
  tags = [
    tag("explainshell", VERSION),
    tag_by_date("explainshell")
  ]
}
