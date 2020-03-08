## Cloudwatch Alert For Service Running Count In ECS Service
resource "aws_cloudwatch_metric_alarm" "Service_Task_Count" {
  count = "${var.alarms_enabled}"
  alarm_name          = "${var.ecs_service_name}_Service_Task_Count_TEST"
  alarm_description   = "Monitoring Service Task Count of ECS Service"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = "${var.alarm_task_count_evaluation_periods}"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ECS"
  period              = "${var.alarm_task_count_period}"
  statistic           = "SampleCount"
  threshold           = "${var.alarm_task_count_threshold}"

  dimensions {
    ServiceName = "${var.ecs_service_name}",
    ClusterName = "${var.cluster_name}"
  }

  ok_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
  insufficient_data_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
  alarm_actions = ["${data.terraform_remote_state.clouwatch-zabbix.sns_topic_arn}"]
}