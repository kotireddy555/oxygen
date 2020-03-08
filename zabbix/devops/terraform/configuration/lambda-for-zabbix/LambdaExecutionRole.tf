data "aws_iam_policy_document" "LambdaExecutionRole-assume-role-policy" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = [
        "lambda.amazonaws.com"
      ]
    }

    effect = "Allow"
    sid    = ""
  }
}

resource "aws_iam_role" "LambdaExecutionRole" {
  name = "Zabbix-LambdaExecutionRole-${var.aws_region}"
  assume_role_policy = "${data.aws_iam_policy_document.LambdaExecutionRole-assume-role-policy.json}"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_role_policy" "lambda-logs-to-cloudwatch" {
  name = "lambda-function-logs-to-cloudwatch"
  role = "${aws_iam_role.LambdaExecutionRole.name}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF

}