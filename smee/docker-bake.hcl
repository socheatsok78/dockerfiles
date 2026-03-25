target "smee" {
  inherits = [ "dockerfiles" ]
  context = "https://github.com/probot/smee.io.git#922d925bc241c2e40a1ec86da631b3dbbdd329cb"
  matrix = {
    "VERSION" = [ "latest" ]
  }
  tags = concat(
    tags("smee", VERSION),
    tag_by_date("smee"),
  )
}
