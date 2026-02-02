target "yt-dlp" {
  inherits = [ "dockerfiles" ]
  context = "yt-dlp"
  tags = [
    tag("yt-dlp", "latest"),
  ]
}
