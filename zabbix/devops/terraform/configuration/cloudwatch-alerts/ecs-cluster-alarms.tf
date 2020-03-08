# Cloudwatch Alert For High CPU Utilization In ECS Cluster
resource "aws_cloudwatch_metric_alarm" "CPUUtilization" {
  count = "${var.alarms_enabled}"
  alarm_name = "${var.cluster_name}-ECS-Cluster-CPUUtilization-TEST"
  alarm_description = "This metric monitors CPU utilization for an ECS Cluster"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "${var.alarm_cpu_util_evaluation_periods}"
  metric_name = "CPUUtilization"
  namespace = "AWS/ECS"
  period = "${var.alarm_cpu_util_period}"
  statistic = "Average"
  threshold = "${var.alarm_cpu_util_threshold}"

  dimensions {
    ClusterName = "${var.cluster_name}"
  }

  ok_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
  insufficient_data_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
  alarm_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
}

## Cloudwatch Alert For High Memory/RAM Utilization In ECS Cluster
resource "aws_cloudwatch_metric_alarm" "MemoryUtilization" {
  count = "${var.alarms_enabled}"
  alarm_name = "${var.cluster_name}-ECS-Cluster-MemoryUtilization-TEST"
  alarm_description = "This metric monitors Memory Utilization for an ECS Cluster"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "${var.alarm_mem_util_evaluation_periods}"
  metric_name = "MemoryUtilization"
  namespace = "AWS/ECS"
  period = "${var.alarm_mem_util_period}"
  statistic = "Average"
  threshold = "${var.alarm_mem_util_threshold}"

  dimensions {
    ClusterName = "${var.cluster_name}"
  }

  ok_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
  insufficient_data_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
  alarm_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
}