variable "aws_region" {}

# Remote State Variables
variable "remote_sns_s3_key" {}

# ECS Details
variable "cluster_name" {}
variable "ecs_service_name" {}
#Alarm
variable "alarms_enabled" {default = true}
variable "alarm_sns_topic_arn" {default = ""}
variable "alarm_cpu_util_evaluation_periods" {default = 10}
variable "alarm_cpu_util_period" {default = 60}
variable "alarm_cpu_util_threshold" { default = 70}

variable "alarm_mem_util_evaluation_periods" {default = 10}
variable "alarm_mem_util_period" {default = 60}
variable "alarm_mem_util_threshold" { default = 80}
# Service Task Count
variable "alarm_task_count_evaluation_periods" {default = 10}
variable "alarm_task_count_period" {default = 60}
variable "alarm_task_count_threshold" { default = 2}