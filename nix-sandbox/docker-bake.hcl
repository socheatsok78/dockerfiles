variable "NIX_VERSION" {
  default = "2.32.8"
}
target "nix-sandbox" {
  inherits = [ "dockerfiles" ]
  context = "nix-sandbox"
  args = {
    NIX_VERSION = NIX_VERSION
  }
  tags = concat(
    tags("nix-sandbox", NIX_VERSION),
  )
}
