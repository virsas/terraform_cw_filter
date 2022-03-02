# tfmod_cw_filter

Terraform module to create cloudwatch filter.

## Dependencies

CW group <https://github.com/virsas/tfmod_cw_group>

## Terraform example

``` terraform
variable "unauthorized_api_calls_metric" { 
  default = {
    name        = "unauthorized_api_calls_metric"
    namespace   = "CISBenchmark"
    patern      = "{($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\")}"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 10
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}

module "cw_filter_aws_config_changes_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  # alarm varables. It is the same variable as the one we use for the alarm later, see the complete configuration below.
  alarm  = var.unauthorized_api_calls_metric
  # the group you log all the cloudtrail logs
  group  = module.cw_cloudtrail.name
}
```

## The Center for Internet Security (CIS) AWS Foundations Benchmark

To comply with the CIX benchmark add following:

``` terraform
variable "unauthorized_api_calls_metric" { 
  default = {
    name        = "unauthorized_api_calls_metric"
    namespace   = "CISBenchmark"
    patern      = "{($.errorCode = \"*UnauthorizedOperation\") || ($.errorCode = \"AccessDenied*\")}"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 10
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}
variable "security_group_changes_metric" { 
  default = {
    name        = "security_group_changes_metric"
    namespace   = "CISBenchmark"
    patern      = "{($.eventName=AuthorizeSecurityGroupIngress) || ($.eventName=AuthorizeSecurityGroupEgress) || ($.eventName=RevokeSecurityGroupIngress) || ($.eventName=RevokeSecurityGroupEgress) || ($.eventName=CreateSecurityGroup) || ($.eventName=DeleteSecurityGroup)}"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 1
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}
variable "network_acl_changes_metric" { 
  default = {
    name        = "network_acl_changes_metric"
    namespace   = "CISBenchmark"
    patern      = "{($.eventName=CreateNetworkAcl) || ($.eventName=CreateNetworkAclEntry) || ($.eventName=DeleteNetworkAcl) || ($.eventName=DeleteNetworkAclEntry) || ($.eventName=ReplaceNetworkAclEntry) || ($.eventName=ReplaceNetworkAclAssociation)}"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 1
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}
variable "gateway_changes_metric" { 
  default = {
    name        = "gateway_changes_metric"
    namespace   = "CISBenchmark"
    patern      = "{($.eventName=CreateCustomerGateway) || ($.eventName=DeleteCustomerGateway) || ($.eventName=AttachInternetGateway) || ($.eventName=CreateInternetGateway) || ($.eventName=DeleteInternetGateway) || ($.eventName=DetachInternetGateway)}"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 1
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}
variable "route_changes_metric" { 
  default = {
    name        = "route_changes_metric"
    namespace   = "CISBenchmark"
    patern      = "{($.eventName=CreateRoute) || ($.eventName=CreateRouteTable) || ($.eventName=ReplaceRoute) || ($.eventName=ReplaceRouteTableAssociation) || ($.eventName=DeleteRouteTable) || ($.eventName=DeleteRoute) || ($.eventName=DisassociateRouteTable)}"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 1
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}
variable "vpc_changes_metric" { 
  default = {
    name        = "vpc_changes_metric"
    namespace   = "CISBenchmark"
    patern      = "{($.eventName=CreateVpc) || ($.eventName=DeleteVpc) || ($.eventName=ModifyVpcAttribute) || ($.eventName=AcceptVpcPeeringConnection) || ($.eventName=CreateVpcPeeringConnection) || ($.eventName=DeleteVpcPeeringConnection) || ($.eventName=RejectVpcPeeringConnection) || ($.eventName=AttachClassicLinkVpc) || ($.eventName=DetachClassicLinkVpc) || ($.eventName=DisableVpcClassicLink) || ($.eventName=EnableVpcClassicLink)}"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 1
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}
variable "no_mfa_console_signin_alarm" { 
  default = {
    name        = "no_mfa_console_signin_alarm"
    namespace   = "CISBenchmark"
    patern      = "{ ($.eventName = \"ConsoleLogin\") && ($.additionalEventData.MFAUsed != \"Yes\") && ($.userIdentity.type = \"IAMUser\") && ($.responseElements.ConsoleLogin = \"Success\") }"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 1
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}
variable "root_usage_metric" { 
  default = {
    name        = "root_usage_metric"
    namespace   = "CISBenchmark"
    patern      = "{ $.userIdentity.type = \"Root\" && $.userIdentity.invokedBy NOT EXISTS && $.eventType != \"AwsServiceEvent\" }"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 1
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}
variable "iam_changes_metric" { 
  default = {
    name        = "iam_changes_metric"
    namespace   = "CISBenchmark"
    patern      = "{($.eventName=DeleteGroupPolicy) || ($.eventName=DeleteRolePolicy) || ($.eventName=DeleteUserPolicy) || ($.eventName=PutGroupPolicy) || ($.eventName=PutRolePolicy) || ($.eventName=PutUserPolicy) || ($.eventName=CreatePolicy) || ($.eventName=DeletePolicy) || ($.eventName=CreatePolicyVersion) || ($.eventName=DeletePolicyVersion) || ($.eventName=AttachRolePolicy) || ($.eventName=DetachRolePolicy) || ($.eventName=AttachUserPolicy) || ($.eventName=DetachUserPolicy) || ($.eventName=AttachGroupPolicy) || ($.eventName=DetachGroupPolicy)}"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 1
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}
variable "cloudtrail_cfg_changes_metric" { 
  default = {
    name        = "cloudtrail_cfg_changes_metric"
    namespace   = "CISBenchmark"
    patern      = "{($.eventName=CreateTrail) || ($.eventName=UpdateTrail) || ($.eventName=DeleteTrail) || ($.eventName=StartLogging) || ($.eventName=StopLogging)}"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 1
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}
variable "console_signin_failure_metric" { 
  default = {
    name        = "console_signin_failure_metric"
    namespace   = "CISBenchmark"
    patern      = "{($.eventName=ConsoleLogin) && ($.errorMessage=\"Failed authentication\")}"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 1
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}
variable "disable_or_delete_cmk_changes_metric" { 
  default = {
    name        = "disable_or_delete_cmk_changes_metric"
    namespace   = "CISBenchmark"
    patern      = "{($.eventSource=kms.amazonaws.com) && (($.eventName=DisableKey) || ($.eventName=ScheduleKeyDeletion))}"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 1
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}
variable "s3_bucket_policy_changes_metric" { 
  default = {
    name        = "s3_bucket_policy_changes_metric"
    namespace   = "CISBenchmark"
    patern      = "{($.eventSource=s3.amazonaws.com) && (($.eventName=PutBucketAcl) || ($.eventName=PutBucketPolicy) || ($.eventName=PutBucketCors) || ($.eventName=PutBucketLifecycle) || ($.eventName=PutBucketReplication) || ($.eventName=DeleteBucketPolicy) || ($.eventName=DeleteBucketCors) || ($.eventName=DeleteBucketLifecycle) || ($.eventName=DeleteBucketReplication))}"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 1
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}
variable "aws_config_changes_metric" { 
  default = {
    name        = "aws_config_changes_metric"
    namespace   = "CISBenchmark"
    patern      = "{($.eventSource=config.amazonaws.com) && (($.eventName=StopConfigurationRecorder) || ($.eventName=DeleteDeliveryChannel) || ($.eventName=PutDeliveryChannel) || ($.eventName=PutConfigurationRecorder))}"
    operator    = "GreaterThanOrEqualToThreshold"
    period      = 300
    eval_period = 1
    threshold   = 1
    statistic   = "Sum"
    missing     = "notBreaching"
  }
}

##
module "cw_filter_unauthorized_api_calls_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.unauthorized_api_calls_metric
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_unauthorized_api_calls_metric" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.unauthorized_api_calls_metric
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_unauthorized_api_calls_metric.id
}
##
module "cw_filter_security_group_changes_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.security_group_changes_metric
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_security_group_changes_metric" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.security_group_changes_metric
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_security_group_changes_metric.id
}
##
module "cw_filter_network_acl_changes_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.network_acl_changes_metric
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_network_acl_changes_metric" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.network_acl_changes_metric
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_network_acl_changes_metric.id
}
##
module "cw_filter_gateway_changes_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.gateway_changes_metric
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_gateway_changes_metric" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.gateway_changes_metric
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_gateway_changes_metric.id
}
##
module "cw_filter_route_changes_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.route_changes_metric
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_route_changes_metric" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.route_changes_metric
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_route_changes_metric.id
}
##
module "cw_filter_vpc_changes_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.vpc_changes_metric
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_vpc_changes_metric" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.vpc_changes_metric
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_vpc_changes_metric.id
}
##
module "cw_filter_no_mfa_console_signin_alarm" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.no_mfa_console_signin_alarm
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_no_mfa_console_signin_alarm" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.no_mfa_console_signin_alarm
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_no_mfa_console_signin_alarm.id
}
##
module "cw_filter_root_usage_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.root_usage_metric
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_root_usage_metric" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.root_usage_metric
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_root_usage_metric.id
}
##
module "cw_filter_iam_changes_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.iam_changes_metric
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_iam_changes_metric" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.iam_changes_metric
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_iam_changes_metric.id
}
##
module "cw_filter_cloudtrail_cfg_changes_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.cloudtrail_cfg_changes_metric
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_cloudtrail_cfg_changes_metric" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.cloudtrail_cfg_changes_metric
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_cloudtrail_cfg_changes_metric.id
}
##
module "cw_filter_console_signin_failure_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.console_signin_failure_metric
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_console_signin_failure_metric" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.console_signin_failure_metric
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_console_signin_failure_metric.id
}
##
module "cw_filter_disable_or_delete_cmk_changes_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.disable_or_delete_cmk_changes_metric
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_disable_or_delete_cmk_changes_metric" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.disable_or_delete_cmk_changes_metric
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_disable_or_delete_cmk_changes_metric.id
}
##
module "cw_filter_s3_bucket_policy_changes_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.s3_bucket_policy_changes_metric
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_s3_bucket_policy_changes_metric" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.s3_bucket_policy_changes_metric
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_s3_bucket_policy_changes_metric.id
}
##
module "cw_filter_aws_config_changes_metric" {
  source = "github.com/virsas/tfmod_cw_filter"
  alarm  = var.aws_config_changes_metric
  group  = module.cw_cloudtrail.name
}
module "cw_alarm_aws_config_changes_metric" {
  source  = "github.com/virsas/tfmod_cw_alarm"
  alarm   = var.aws_config_changes_metric
  sns     = [module.sns_topic_alarms.arn]
  filter  = module.cw_filter_aws_config_changes_metric.id
}
```
