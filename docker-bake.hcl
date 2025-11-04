variable "DATE" {
  default = formatdate("YYYY-MM-DD", timestamp())
}
variable "RELEASE_BY_DATE_TAG" {
  default = "RELEASE.${DATE}"
}

variable "GITHUB_REPOSITORY_OWNER" {
  default = "socheatsok78-lab"
}

function "tag" {
  params = [name, version]
  result = "ghcr.io/${GITHUB_REPOSITORY_OWNER}/${name}:${version}"
}

function "tag_by_date" {
  params = [name]
  result = "ghcr.io/${GITHUB_REPOSITORY_OWNER}/${name}:${RELEASE_BY_DATE_TAG}"
}

group "default" {
  targets = [
    "caddy",
    // "caddy-json-schema",
    "caddy-layer4",
    "github-cli",
    "go-discover",
    "go-discover-dockerswarm",
    "go-netaddrs",
    "openssl-dhparam",
    "rustup-init",
    "xiaomi-cloud-token-extractor",
  ]
}

group "schedule" {
  targets = [
    "db-ip",
    "maxminddb",
    "openssl-dhparam",
  ]
}

target "docker-metadata-action" {}
target "github-metadata-action" {}

target "dockerfiles" {
  inherits = [
    "docker-metadata-action",
    "github-metadata-action",
  ]
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
  secret = [
    "id=GIT_AUTH_TOKEN.github.com,env=GITHUB_TOKEN",
  ]
}

// Buildkit

variable "BUILDKIT_VERSION" {
  type = list(string)
  default = [
    "buildx-stable-1",
  ]
}

target "buildkit" {
  inherits = [ "dockerfiles" ]
  matrix = {
    version = BUILDKIT_VERSION
  }
  name = "buildkit-${replace(version, ".", "-")}"
  context = "buildkit"
  args = {
    BUILDKIT_VERSION = version
  }
  tags = [
    tag("buildkit", version),
  ]
}

// Caddy

variable "CADDY_VERSION" {
  type = list(string)
  default = [
    "2.10.2",
  ]
}

group "caddies" {
  targets = [
    "caddy",
    "caddy-json-schema",
    "caddy-layer4",
  ]
}

target "caddy" {
  inherits = [ "dockerfiles" ]
  matrix = {
    version = CADDY_VERSION
  }
  name = "caddy-${replace(version, ".", "-")}"
  context = "caddy"
  args = {
    CADDY_BUILDER_VERSION = regex("^(\\d+\\.\\d+)", version)[0]
    CADDY_VERSION = version
    CADDY_TARGET = "caddy"
  }
  tags = [
    tag("caddy", version),
    tag_by_date("caddy")
  ]
}

target "caddy-json-schema" {
  inherits = [ "dockerfiles" ]
  matrix = {
    version = CADDY_VERSION
  }
  name = "caddy-json-schema-${replace(version, ".", "-")}"
  context = "caddy-json-schema"
  args = {
    CADDY_VERSION = version
    CADDY_TARGET = "json-schema"
  }
  tags = [
    tag("caddy-json-schema", version),
    tag_by_date("caddy-json-schema")
  ]
}

target "caddy-layer4" {
  inherits = [ "dockerfiles" ]
  matrix = {
    version = CADDY_VERSION
  }
  name = "caddy-l4-${replace(version, ".", "-")}"
  description = "Caddy with TCP/UDP support"
  context = "caddy-layer4"
  args = {
    CADDY_VERSION = version
    CADDY_TARGET = "layer4"
  }
  tags = [
    tag("caddy-l4", version),
    tag_by_date("caddy-l4")
  ]
}

// DB-IP

target "db-ip" {
  inherits = [ "dockerfiles" ]
  matrix = {
    db = [
      "asn-lite",
      "city-lite",
      "country-lite",
    ]
  }
  name = "db-ip-${db}"
  context = "db-ip"
  target = db
  args = {
    DATE = formatdate("YYYY-MM", timestamp())
  }
  tags = [
    tag("db-ip", db),
  ]
}

// GitHub CLI

target "github-cli" {
  inherits = [ "dockerfiles" ]
  context = "github-cli"
  tags = [
    tag("github-cli", "latest"),
    tag_by_date("github-cli")
  ]
}

// Go modules

target "go-discover" {
  inherits = [ "dockerfiles" ]
  context = "go-discover"
  tags = [
    tag("go-discover", "latest"),
    tag_by_date("go-discover")
  ]
}

target "go-discover-dockerswarm" {
  inherits = [ "dockerfiles" ]
  context = "go-discover-dockerswarm"
  tags = [
    tag("go-discover-dockerswarm", "latest"),
    tag_by_date("go-discover-dockerswarm")
  ]
}

target "go-netaddrs" {
  inherits = [ "dockerfiles" ]
  context = "go-netaddrs"
  tags = [
    tag("go-netaddrs", "latest"),
    tag_by_date("go-netaddrs")
  ]
}

// MaxMindDB

target "maxminddb" {
  inherits = [ "dockerfiles" ]
  matrix = {
    db = [
      "geolite2-asn",
      "geolite2-city",
      "geolite2-country",
    ]
  }
  name = "maxminddb-${db}"
  context = "maxminddb"
  target = db
  secret = [
    "id=MAXMINDDB_USER_ID,env=MAXMINDDB_USER_ID",
    "id=MAXMINDDB_LICENSE_KEY,env=MAXMINDDB_LICENSE_KEY",
  ]
  tags = [
    tag("maxminddb", db),
  ]
}

// OpenSSL DHParam

target "openssl-dhparam" {
  inherits = [ "dockerfiles" ]
  context = "openssl-dhparam"
  tags = [
    tag("openssl-dhparam", "latest"),
    tag_by_date("openssl-dhparam")
  ]
}

// Rustup
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
  tags = [
    tag("rustup-init", "${VERSION}${VARIANT.suffix}")
  ]
}

// Maiscellaneous

target "xiaomi-cloud-token-extractor" {
  inherits = [ "dockerfiles" ]
  context = "https://github.com/PiotrMachowski/Xiaomi-cloud-tokens-extractor.git#521eab2bbc7df5c03dc04705ac02bdcb48634c43"
  matrix = {
    "VERSION" = [ "latest" ]
  }
  tags = [
    tag("xiaomi-cloud-token-extractor", VERSION),
    tag_by_date("xiaomi-cloud-token-extractor")
  ]
}

target "rover" {
  inherits = [ "dockerfiles" ]
  context = "rover"
  tags = [
    tag("rover", "latest"),
    tag_by_date("rover")
  ]
}
