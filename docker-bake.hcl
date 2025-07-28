variable "GITHUB_REPOSITORY_OWNER" {
  default = "socheatsok78-lab"
}

group "default" {
  targets = [
    "db-ip",
    "go-discover-dockerswarm",
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

target "go-discover-dockerswarm" {
  inherits = [ "dockerfiles" ]
  context = "go-discover-dockerswarm"
  tags = [
    "ghcr.io/${GITHUB_REPOSITORY_OWNER}/go-discover-dockerswarm:latest"
  ]
}
