variable "NIX_VERSION" {
  default = "2.35.1"
}

target "buildkit-nix" {
  inherits = [ "dockerfiles" ]
  context = "buildkit-nix"
  args = {
    NIX_VERSION = NIX_VERSION
  }
  tags = concat(
    tags("buildkit-nix", NIX_VERSION),
  )
}
