target "smee" {
  inherits = [ "dockerfiles" ]
  context = "smee"
  contexts = {
    "smee-builder" = "target:smee-builder"
  }
  matrix = {
    "VERSION" = [ "latest" ]
  }
  tags = concat(
    tags("smee", VERSION),
    tag_by_date("smee"),
  )
}

target "smee-builder" {
  inherits = [ "dockerfiles" ]
  context = "https://github.com/probot/smee.io.git#922d925bc241c2e40a1ec86da631b3dbbdd329cb"
  output = [ "type=cacheonly" ]
}
