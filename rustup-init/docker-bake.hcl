target "rustup-init" {
  inherits = [ "dockerfiles" ]
  context = "rustup-init"
  matrix = {
    "VERSION" = [
      "1.28.2",
    ]
    "VARIANT" = [
      {
        name = "gnu",
        suffix = "",
        platforms = [
          "linux/amd64",
          "linux/arm64",
          "linux/arm/v7",
          "linux/s390x",
          "linux/ppc64le",
        ]
      },
      {
        name = "musl",
        suffix = "-musl",
        platforms = [
          "linux/amd64",
          "linux/arm64",
          "linux/ppc64le",
        ]
      },
    ]
  }
  name = "rustup-init-${sanitize(VERSION)}${VARIANT.suffix}"
  args = {
    VERSION = VERSION
  }
  dockerfile = "${VARIANT.name}.Dockerfile"
  platforms = VARIANT.platforms
  tags = concat(
    tags("rustup-init", "${VERSION}${VARIANT.suffix}"),
  )
}
