provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_lambda_function" "LambdaFunctionForZabbix" {
  filename = "${path.module}/code/index.zip"
  function_name = "SNSTriggerForLambda"
  handler = "index.lambda_handler"
  role = "${aws_iam_role.LambdaExecutionRole.arn}"
  runtime = "python2.7"
  source_code_hash = "${base64sha256(file("${path.module}/code/index.zip"))}"

  timeout = "${var.timeout}"

  tags {
    Name = "SNSTriggerForLambda",
    Category = "Environment:${var.environment}+Criticality:${var.tag_criticality}+Role:Application",
    Owner = "EPRID:${var.tag_eprid}+Name:${var.tag_app_name}+Contact:${var.tag_contact_email}",
    CostManagement = "CostCenter:${var.tag_cost_center}+MRU:${var.tag_mru}+LocationCode:${var.tag_location_code}"
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_lambda_permission" "sns_invokes_lambda" {
  statement_id = "AllowExecutionFromSNS"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.LambdaFunctionForZabbix.arn}"
  principal = "sns.amazonaws.com"
  source_arn = "${aws_sns_topic.sns-topic-for-zabbix.arn}"
}