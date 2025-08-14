variable "DATE" {
  default = formatdate("YYYY-MM-DD", timestamp())
}
variable "RELEASE_BY_DATE_TAG" {
  default = "RELEASE.${DATE}"
}

variable "GITHUB_REPOSITORY_OWNER" {
  default = "socheatsok78-lab"
}

group "default" {
  targets = [
    "caddy",
    "caddy-json-schema",
    "caddy-l4",
    "github-cli",
    "go-discover",
    "go-discover-dockerswarm",
    "go-netaddrs",
    "openssl-dhparam",
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
}

// Caddy

variable "CADDY_VERSION" {
  type = list(string)
  default = [
    "2.10",
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
    CADDY_VERSION = version
    CADDY_TARGET = "caddy"
  }
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/caddy:${version}",
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/caddy:${RELEASE_BY_DATE_TAG}",
  ]
}

target "caddy-json-schema" {
  inherits = [ "dockerfiles" ]
  matrix = {
    version = CADDY_VERSION
  }
  name = "caddy-json-schema-${replace(version, ".", "-")}"
  context = "caddy"
  args = {
    CADDY_VERSION = version
    CADDY_TARGET = "caddy-json-schema"
  }
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/caddy-json-schema:${version}",
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/caddy-json-schema:${RELEASE_BY_DATE_TAG}",
  ]
}

target "caddy-l4" {
  inherits = [ "dockerfiles" ]
  matrix = {
    version = CADDY_VERSION
  }
  name = "caddy-l4-${replace(version, ".", "-")}"
  description = "Caddy with TCP/UDP support"
  context = "caddy"
  args = {
    CADDY_VERSION = version
    CADDY_TARGET = "layer4"
  }
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/caddy-l4:${version}",
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/caddy-l4:${RELEASE_BY_DATE_TAG}",
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
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/db-ip:${db}",
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/db-ip:${RELEASE_BY_DATE_TAG}",
  ]
}

// GitHub CLI

target "github-cli" {
  inherits = [ "dockerfiles" ]
  context = "github-cli"
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/github-cli:latest",
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/github-cli:${RELEASE_BY_DATE_TAG}",
  ]
}

// Go modules

target "go-discover" {
  inherits = [ "dockerfiles" ]
  context = "go-discover"
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/go-discover:latest",
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/go-discover:${RELEASE_BY_DATE_TAG}",
  ]
}

target "go-discover-dockerswarm" {
  inherits = [ "dockerfiles" ]
  context = "go-discover-dockerswarm"
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/go-discover-dockerswarm:latest",
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/go-discover-dockerswarm:${RELEASE_BY_DATE_TAG}",
  ]
}

target "go-netaddrs" {
  inherits = [ "dockerfiles" ]
  context = "go-netaddrs"
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/go-netaddrs:latest",
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/go-netaddrs:${RELEASE_BY_DATE_TAG}",
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
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/maxminddb:${db}",
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/maxminddb:${RELEASE_BY_DATE_TAG}",
  ]
  secret = [
    "id=MAXMINDDB_USER_ID,env=MAXMINDDB_USER_ID",
    "id=MAXMINDDB_LICENSE_KEY,env=MAXMINDDB_LICENSE_KEY",
  ]
}

// OpenSSL DHParam

target "openssl-dhparam" {
  inherits = [ "dockerfiles" ]
  context = "openssl-dhparam"
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/openssl-dhparam:latest",
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/openssl-dhparam:${RELEASE_BY_DATE_TAG}",
  ]
}
