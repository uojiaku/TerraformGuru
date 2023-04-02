provider "aws" {
  region = "us-east-1"
}

# module "zones" {
#   source  = "terraform-aws-modules/route53/aws//modules/zones"
#   version = "~> 2.0"

#   zones = {
#     "zorocode.org" = {
#       comment = "This is ZoroCode!"
#     }
#   }
# }

data "aws_route53_zone" "selected" {
    name    = "zorocode.org."
}

module "records" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

#   zone_name = keys(module.zones.route53_zone_zone_id)[0]
  zone_id = data.aws_route53_zone.selected.zone_id

  records = [
    {
      name    = "mbido"
      type    = "A"
      ttl     = 300
      records = [
        "10.113.12.55",
      ]
    }
  ]

}