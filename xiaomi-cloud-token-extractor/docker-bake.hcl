target "xiaomi-cloud-token-extractor" {
  inherits = [ "dockerfiles" ]
  context = "https://github.com/PiotrMachowski/Xiaomi-cloud-tokens-extractor.git#521eab2bbc7df5c03dc04705ac02bdcb48634c43"
  matrix = {
    "VERSION" = [ "latest" ]
  }
  tags = concat(
    tags("xiaomi-cloud-token-extractor", VERSION),
    tag_by_date("xiaomi-cloud-token-extractor"),
  )
}
