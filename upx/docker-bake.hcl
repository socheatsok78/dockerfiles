target "upx" {
  inherits = [ "dockerfiles" ]
  context = "upx"
  tags = concat(
    tags("upx", "latest"),
  )
}
