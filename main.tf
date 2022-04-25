provider "aws" {
  region = var.region
}

resource "aws_cloudwatch_log_metric_filter" "root" {
  name           = var.alarm.name
  pattern        = var.alarm.patern
  log_group_name = var.group

  metric_transformation {
    name            = var.alarm.name
    namespace       = var.alarm.namespace
    value           = 1
    default_value   = 0
  }
}