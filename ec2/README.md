# EC2(Elastic Compute Cloud)

Terraform module which creates an EC2 instances on AWS.

 An EC2 instance is a virtual server in Amazon's Elastic Compute Cloud (EC2) for running applications on the AWS infrastructure.
* [EC2 Instance](https://www.terraform.io/docs/providers/aws/r/instance.html)

## Usage

```hcl

module "ec2" {
  source = "git::ssh://git@github.azc.ext.hp.com/MSSI-DevOps/TerraformModules.git//ec2?ref=master"

   name                   = "ARC"
   ami                    = "ami-ebd02392"
   instance_type          = "t2.micro"
   key_name               = "user1"
   vpc_security_group_ids = ["sg-12345678"]
   subnet_id              = "subnet-eddcdzz4"
   tag_cost_center        = "US12345678"
   tag_mru                = "7BBK"
   tag_location_code      = "47II19240000HO00"
   tag_eprid              = "ARC12345"
}

```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ami | ID of AMI to use for the instance | string | "" | yes |
| default_sgs | Security group | list | <list> |  yes  |
| instance_type | The type of instance | string |  ""  | yes |
| iam_instance_profile | The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile | string | "" | no |
| key_name | The key name to use for the instance | string | "" | no |
| private_ip | Private IP address to associate with the instance in a VPC | string | - | no |
| sg_ingress_443_enabled | Enabling the inbound rule for port 443 | Boolean | false | no |
| sg_ingress_80_enabled | Enabling the inbound rule for port 80 | Boolean | false | no   |
| sg_engress_all_enabled | Enabling all the outbound rules | Boolean | false | no |
| sg_ingress_custom_rule_enabled | Enabling all the custom rules | Boolean | false | no |
| subnet_id | The VPC Subnet ID to launch in | string | - | yes |
| vpc_id | Id of the VPC | String | - | yes |
| tag_app_name | The name of the App | string | "" | yes |
| tag_criticality | - | string | - | yes |
| tag_cost_center | Id for the cost center | string | " " | yes |
| tag_contact_email | The email id to contact | string | - | yes |
| tag_eprid | The application id in Auto Scaling Groups | string | - | yes |
| tag_location_code | Location code | string | - | yes |


## Outputs

| Name | Description |
|------|-------------|
| instance_id | Instance ID |
| private_ip | private IP address assigned to the instance |
| sg_id | ID of the security group |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
