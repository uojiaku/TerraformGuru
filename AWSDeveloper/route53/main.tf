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
## Simple Routing Policy
module "simple" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

#   zone_name = keys(module.zones.route53_zone_zone_id)[0]
  zone_id = data.aws_route53_zone.selected.zone_id

  records = [
    {
      name    = "mbido"
      type    = "A"
    #   type    = "CNAME"
      ttl     = 300
      records = [
        "34.235.167.218",
      ]
    #   alias = {
    #      name    = "eligwe-alb-545815053.us-east-1.elb.amazonaws.com"
    #     zone_id = data.aws_route53_zone.selected.zone_id
    #  #    zone_id = "Z3IU6ZTTTMW8XB"
    #   }
    }
  ]

}

## Weighted Routing Policy

module "weighted" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_id = data.aws_route53_zone.selected.zone_id

  records = [
    {
      name    = "gwam"
      type    = "A"
      ttl     = 5
      records = [
        "34.235.167.218",
      ]
      weighted_routing_policy = {
        weight = 10
      }
    }, 
    {
      name    = "maka"
      type    = "A"
      ttl     = 5
      records = [
        "34.235.167.220",
      ]
      weighted_routing_policy = {
        weight = 10
      }
    }, 
  ]
}

## Latency Routing Policy

module "latency" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_id = data.aws_route53_zone.selected.zone_id

  records = [
    {
      name    = "itoolu"
      type    = "A"
      ttl     = 5
      records = [
        "34.235.167.218",
      ]
      weighted_routing_policy = {
        region = "us-east-1"
      }
    }, 
    {
      name    = "iri"
      type    = "A"
      ttl     = 5
      records = [
        "34.235.167.220",
      ]
      latency_routing_policy = {
        region = "eu-west-1"
      }
    }, 
  ]
}

## Route53 Health Check
resource "aws_route53_health_check" "lekwe" {
    ip_address              = "34.235.167.218"
    port                    = 80
    type                    = "HTTP"
    resource_path           = "/"
    failure_threshold       = "3"
    request_interval        = "30"
}

resource "aws_route53_health_check" "gawa" {
    ip_address              = "34.235.167.220"
    port                    = 80
    type                    = "HTTP"
    resource_path           = "/"
    failure_threshold       = "3"
    request_interval        = "30"
}

## Calculated Health Check
resource "aws_route53_health_check" "gawa" {
    type                    = "CALCULATED"
    child_health_threshold  = 2
    child_healthchecks      = [aws_route53_health_check.lekwe.id, aws_route53_health_check.gawa.id]   
}

## CloudWatch Health Check  (untested)
resource "aws_cloudwatch_metric_alarm" "" {
  alarm_name          = "terraform-test-foobar5"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric monitors ec2 cpu utilization"    
}

resource "aws_route53_health_check" "gawa" {
    type                            = "CLOUDWATCH_METRIC"
    cloudWatch_alarm_name           = aws_cl
    cloudwatch_alarm_region         = "us-west-2"
    insufficient_data_health_status = "Healthy"   
}

## Failover Routing Policy

module "failover" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_id = data.aws_route53_zone.selected.zone_id

  records = [
    {
      name    = "failover"   # failover.zorocode.org
      type    = "A"
      ttl     = 60
      health_check_id = aws_route53_health_check.gawa.id
      records = [
        "34.235.167.218",
      ]
      failover_routing_policy = {
        type = "PRIMARY"
      }
    }, 
    {
      name    = "failover" # failover.zorocode.org
      type    = "A"
      ttl     = 60
      health_check_id = aws_route53_health_check.gawa.id
      records = [
        "34.235.167.220",
      ]
      failover_routing_policy = {
        type = "SECONDARY"
      }
    }, 
  ]
}

## Geolocation Routing Policy

module "geolocation" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  zone_id = data.aws_route53_zone.selected.zone_id

  records = [
    {
      name    = "geo"   # geo.zorocode.org
      type    = "A"
      ttl     = 60
      health_check_id = aws_route53_health_check.gawa.id
      records = [
        "34.235.167.218",
      ]
      geolocation_routing_policy = {
        continent = "EU"
      }
    }, 
    {
      name    = "geo"   # geo.zorocode.org
      type    = "A"
      ttl     = 60
      health_check_id = aws_route53_health_check.gawa.id
      records = [
        "34.235.167.220",
      ]
      geolocation_routing_policy = {
        continent = "ASIA"
      }
    }, 
  ]
}

## Geoproximity Traffic Policy -- useful for shifting traffic to another region based on the bias value  (revisit when possible) Video 101

data "aws_region" "current" {}

data "aws_route53_traffic_policy_document" "example" {
  record_type = "A"
  start_rule  = "site_switch"

  geo_proximity_location {
    region                  = "ap-southeast-1"
    bias                    = 0
    endpoint_reference      = "ap-southeast-1"
    health_check            =
    latitude                =
    longitude               =
    rule_reference          =
    evaluate_target_health  =
  }

  geo_proximity_location {
    region                  = "us-east-1"
    bias                    = 0
    endpoint_reference      = "us-east-1"
    health_check            =
    latitude                =
    longitude               =
    rule_reference          =
    evaluate_target_health  =
  }

  rule {
    id   = "site_switch"
    type = "failover"

    primary {
      endpoint_reference = "my_elb"
    }
    secondary {
      endpoint_reference = "site_down_banner"
    }
  }
}

resource "aws_route53_traffic_policy" "example" {
  name     = "example"
  comment  = "example comment"
  document = data.aws_route53_traffic_policy_document.example.json
}


