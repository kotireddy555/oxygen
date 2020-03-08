provider "aws" {
  region = "${var.aws_region}"
}

/*
This module creates the SNS topic
*/
module "create_sns_topic" {
  source = "git::ssh://git@github.azc.ext.hp.com/MSSI-DevOps/TerraformModules.git//sns?ref=v0.12"

  # Common
  name    = "${var.name}"
  display_name = "${var.display_name}"
  subscribe_identifiers = ["${var.subscribe_identifiers}"]
  publish_identifiers = ["${var.publish_identifiers}"]
}