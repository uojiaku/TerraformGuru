
#   provisioner "local-exec" {
#     command = "ssh-keygen -q -t rsa -N '' -f public_key <<<y >/dev/null 2>&1"
#   }

## openssl genrsa -out key.pem
## openssl rsa -pubout -in key.pem -out pubkey.pem

resource "aws_cloudfront_public_key" "this" {
  comment     = "goat public key"
  encoded_key = file("pubkey.pem")
  name        = "goat-public-key"
}

resource "aws_cloudfront_key_group" "this" {
  comment = "goat key group"
  items   = [aws_cloudfront_public_key.this.id]
  name    = "goat-key-group"
}