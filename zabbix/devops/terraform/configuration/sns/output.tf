output "topic_arn" {
  value = "${module.create_sns_topic.arn}"
}

output "topic_name" {
  value = "${module.create_sns_topic.name}"
}