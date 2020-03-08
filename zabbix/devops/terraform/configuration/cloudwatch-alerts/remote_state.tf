terraform {
  # The configuration for this backend will be filled in by Terragrunt
  backend "s3" {}
}

data "aws_caller_identity" "current" {}

locals {
  remote_state_s3_bucket = "${data.aws_caller_identity.current.account_id}-terraform-remote-state-storage"
}

data "terraform_remote_state" "clouwatch-zabbix" {
  backend = "s3"
  config = {
    bucket = "${local.remote_state_s3_bucket}"
    key    = "${var.remote_sns_s3_key}"
    region = "${var.aws_region}"
  }
}