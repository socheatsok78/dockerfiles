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

function "tag_by_date_with_prefix" {
  params = [name, prefix]
  result = "ghcr.io/${GITHUB_REPOSITORY_OWNER}/${name}:${prefix}.${RELEASE_BY_DATE_TAG}"
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
}


group "default" {
  targets = [
    // "caddy-json-schema",
    "caddy-layer4",
    "caddy",
    "certigo",
    "certstrap",
    "github-cli",
    "go-discover-dockerswarm",
    "go-discover",
    "go-netaddrs",
    "haproxy",
    "openssl-dhparam",
    "pishrink",
    "rustup-init",
    "snmp-exporter-generator",
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

// Define individual targets, this will be merged with
// the `${targets}/docker-bake.hcl` files during bake execution.
target "targets" {
  matrix = {
    targets = [
      "caddy-json-schema",
      "caddy-layer4",
      "caddy",
      "certigo",
      "certstrap",
      "db-ip",
      "github-cli",
      "go-discover-dockerswarm",
      "go-discover",
      "go-netaddrs",
      "haproxy",
      "maxminddb",
      "openssl-dhparam",
      "pishrink",
      "rustup-init",
      "snmp-exporter-generator",
      "xiaomi-cloud-token-extractor",
    ]
  }
  name = targets
  context = targets
}
