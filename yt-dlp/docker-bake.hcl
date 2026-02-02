target "yt-dlp" {
  inherits = [ "dockerfiles" ]
  context = "yt-dlp"
  tags = concat(
    tags("yt-dlp", "latest"),
  )
}
