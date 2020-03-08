# Tags
environment = "dev"
tag_criticality = "Normal"
tag_eprid = "-NoEPRID-"
tag_app_name = "MSSI-DevOps"
tag_contact_email = "eric.dalling@hp.com"
tag_cost_center = "US98018935"
tag_mru = "C163"
tag_location_code = "11008PMO00000000"

# ECS
cluster_name = "mssi-devops-pro"
ecs_service_name = "ecs-service-sample-dev"

# SNS
name = "mssi-devops-cloudwatch-alarm-sns-zabbix"
display_name = "SNS Topic For Zabbix"
subscribe_identifiers = "*"
publish_identifiers = "*"

# Variables that refer to remote state file
remote_sns_s3_key = "dev/lambda-for-zabbix/clouwatch-zabbix/terraform.tfstate"