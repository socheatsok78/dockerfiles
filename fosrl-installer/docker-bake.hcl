variable "PANGOLIN_VERSION" {
  default = "1.22.0"
}
target "fosrl-installer" {
  inherits = [ "dockerfiles" ]
  context = "fosrl-installer"
  args = {
    PANGOLIN_VERSION = PANGOLIN_VERSION
  }
  tags = concat(
    tags("fosrl-installer", "latest"),
    tags("fosrl-installer", PANGOLIN_VERSION),
  )
}
