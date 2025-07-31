variable "GITHUB_REPOSITORY_OWNER" {
  default = "socheatsok78-lab"
}

group "default" {
  targets = [
    "caddy",
    "github-cli",
    "go-discover",
    "go-discover-dockerswarm",
    "go-netaddrs",
  ]
}

group "schedule" {
  targets = [
    "db-ip",
    "maxminddb",
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

target "caddy" {
  inherits = [ "dockerfiles" ]
  matrix = {
    version = [
      "2.10",
    ]
  }
  name = "caddy-${replace(version, ".", "-")}"
  context = "caddy"
  args = {
    CADDY_VERSION = version
  }
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/caddy:${version}"
  ]
}

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
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/db-ip:${db}"
  ]
}

target "github-cli" {
  inherits = [ "dockerfiles" ]
  context = "github-cli"
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/github-cli:latest"
  ]
}

target "go-discover" {
  inherits = [ "dockerfiles" ]
  context = "go-discover"
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/go-discover:latest"
  ]
}

target "go-discover-dockerswarm" {
  inherits = [ "dockerfiles" ]
  context = "go-discover-dockerswarm"
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/go-discover-dockerswarm:latest"
  ]
}

target "go-netaddrs" {
  inherits = [ "dockerfiles" ]
  context = "go-netaddrs"
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/go-netaddrs:latest"
  ]
}

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
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/maxminddb:${db}"
  ]
  secret = [
    "id=MAXMINDDB_USER_ID,env=MAXMINDDB_USER_ID",
    "id=MAXMINDDB_LICENSE_KEY,env=MAXMINDDB_LICENSE_KEY",
  ]
}
