target "caddy-file-browser" {
  inherits = [ "dockerfiles" ]
  context = "caddy-file-browser"
  tags = concat(
    tags("caddy-file-browser", "latest"),
  )
}
