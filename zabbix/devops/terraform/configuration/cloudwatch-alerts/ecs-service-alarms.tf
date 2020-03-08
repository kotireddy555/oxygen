## Cloudwatch Alert For High CPU Utilization In ECS Service
resource "aws_cloudwatch_metric_alarm" "ECS_CPUUtilization" {
  count = "${var.alarms_enabled}"
  alarm_name          = "${var.ecs_service_name}_CPUUtilization_TEST"
  alarm_description   = "Monitoring CPU utilization of ECS Service"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "${var.alarm_cpu_util_evaluation_periods}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "${var.alarm_cpu_util_period}"
  statistic           = "Average"
  threshold           = "${var.alarm_cpu_util_threshold}"

  dimensions {
    ServiceName = "${var.ecs_service_name}",
    ClusterName = "${var.cluster_name}"
  }

  ok_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
  insufficient_data_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
  alarm_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
}

## Cloudwatch Alert For High Memory/RAM Utilization In ECS Service
resource "aws_cloudwatch_metric_alarm" "ECS_MemoryUtil" {
  count = "${var.alarms_enabled}"
  alarm_name          = "${var.ecs_service_name}_MemoryUtilization_TEST"
  alarm_description   = "Monitoring memory utilization of ECS Service"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "${var.alarm_mem_util_evaluation_periods}"
  metric_name         = "MemoryUtilization"
  namespace           = "AWS/ECS"
  period              = "${var.alarm_mem_util_period}"
  statistic           = "Average"
  threshold           = "${var.alarm_mem_util_threshold}"

  dimensions {

    ServiceName = "${var.ecs_service_name}",
    ClusterName = "${var.cluster_name}"

  }

  ok_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
  insufficient_data_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
  alarm_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
}
