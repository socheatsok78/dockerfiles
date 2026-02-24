variable "DATE" {
  default = formatdate("YYYY-MM-DD", timestamp())
}
variable "RELEASE_BY_DATE_TAG" {
  default = "RELEASE.${DATE}"
}

variable "GITHUB_REPOSITORY_OWNER" {
  default = "socheatsok78-lab"
}

function "ghcr" {
  params = [name, version]
  result = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/${name}:${version}"
  ]
}

function "tags" {
  params = [name, version]
  result = concat(
    ghcr(name, version),
  )
}

function "tag_by_date" {
  params = [name]
  result = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/${name}:${RELEASE_BY_DATE_TAG}"
  ]
}

function "tag_by_date_with_prefix" {
  params = [name, prefix]
  result = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/${name}:${prefix}.${RELEASE_BY_DATE_TAG}"
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
}


group "default" {
  targets = [
    "angie",
    "caddy-layer4",
    "caddy",
    "certigo",
    "certstrap",
    "figlet",
    "fosrl-installer",
    "github-cli",
    "go-discover-dockerswarm",
    "go-discover",
    "go-netaddrs",
    "haproxy",
    "openfortivpn",
    "pishrink",
    "rover",
    "rustup-init",
    "snmp-exporter-generator",
    "socat",
    "ssh",
    "unzip",
    "xiaomi-cloud-token-extractor",
    "yt-dlp",
  ]
}

group "schedule" {
  targets = [
    "schedule-monthly",
    "schedule-yearly",
  ]
}

group "schedule-monthly" {
  targets = [
    "db-ip",
    "maxminddb",
  ]
}

group "schedule-yearly" {
  targets = [
    "openssl-dhparam",
  ]
}

group "archived" {
  targets = [
    "caddy-json-schema",
  ]
}

// Define individual targets, this will be merged with
// the `${targets}/docker-bake.hcl` files during bake execution.
target "targets" {
  matrix = {
    targets = [
      "angie",
      "caddy-json-schema",
      "caddy-layer4",
      "caddy",
      "certigo",
      "certstrap",
      "db-ip",
      "figlet",
      "fosrl-installer",
      "github-cli",
      "go-discover-dockerswarm",
      "go-discover",
      "go-netaddrs",
      "haproxy",
      "maxminddb",
      "openfortivpn",
      "openssl-dhparam",
      "pishrink",
      "rover",
      "rustup-init",
      "snmp-exporter-generator",
      "socat",
      "ssh",
      "unzip",
      "xiaomi-cloud-token-extractor",
      "yt-dlp",
    ]
  }
  name = targets
  context = targets
}
