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
  result = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/${name}:${version}",
  ]
}

function "tags" {
  params = [name, version]
  result = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/${name}:${version}",
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/${name}:${RELEASE_BY_DATE_TAG}",
  ]
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
  tags = tags("caddy", version)
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
    CADDY_TARGET = "json-schema"
  }
  tags = tags("caddy-json-schema", version)
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
  tags = tags("caddy-l4", version)
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
  tags = tags("db-ip", db)
}

// GitHub CLI

target "github-cli" {
  inherits = [ "dockerfiles" ]
  context = "github-cli"
  tags = tags("github-cli", "latest")
}

// Go modules

target "go-discover" {
  inherits = [ "dockerfiles" ]
  context = "go-discover"
  tags = tags("go-discover", "latest")
}

target "go-discover-dockerswarm" {
  inherits = [ "dockerfiles" ]
  context = "go-discover-dockerswarm"
  tags = tags("go-discover-dockerswarm", "latest")
}

target "go-netaddrs" {
  inherits = [ "dockerfiles" ]
  context = "go-netaddrs"
  tags = tags("go-netaddrs", "latest")
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
  tags = tags("maxminddb", db)
}

// OpenSSL DHParam

target "openssl-dhparam" {
  inherits = [ "dockerfiles" ]
  context = "openssl-dhparam"
  tags = tags("openssl-dhparam", "latest")
}
