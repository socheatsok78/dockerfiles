variable "PANGOLIN_VERSION" {
  default = "1.24.0"
}
target "fosrl-installer" {
  inherits = [ "dockerfiles" ]
  context = "fosrl-installer"
  args = {
    GO_VERSION = "1.26"
    PANGOLIN_VERSION = PANGOLIN_VERSION
  }
  tags = concat(
    tags("fosrl-installer", "latest"),
    tags("fosrl-installer", PANGOLIN_VERSION),
  )
}
