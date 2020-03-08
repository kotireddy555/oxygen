variable "app_name" {}
variable "environment" {}

#Tags
variable "tag_app_name" {}
variable "tag_criticality" {}
variable "tag_contact_email" {}
variable "tag_eprid" {}
variable "tag_cost_center" {}
variable "tag_mru" {}
variable "tag_location_code" {}

#EC2
variable "user_data" {}
variable "instance_type" {}
variable "key_name" {}
variable "iam_instance_profile" {}
variable "vpc_id" {}
variable "ami" {}
variable "subnet_id" {}
variable "private_ip" {default = ""}
variable "default_sgs" {type = "list"}

variable "sg_ingress_443_enabled" {default = false}
variable "sg_ingress_80_enabled" {default = false}
variable "sg_egress_all_enabled" {default = false}
variable "custom_port" { default = 0}
variable "sg_ingress_custom_rule_enabled" {default = false}