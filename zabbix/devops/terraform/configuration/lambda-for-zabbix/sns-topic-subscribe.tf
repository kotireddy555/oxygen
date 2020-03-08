resource "aws_sns_topic" "sns-topic-for-zabbix" {
  name = "mssi-devops-cloudwatch-alarm-sns-zabbix"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_sns_topic_subscription" "LambdaSubscriptionToSNSTopic" {
  #topic_arn = "${aws_sns_topic.ecs-containter-draining-sns-topic.arn}"
  topic_arn = "${aws_sns_topic.sns-topic-for-zabbix.arn}"
  protocol = "lambda"
  endpoint = "${aws_lambda_function.LambdaFunctionForZabbix.arn}"
}