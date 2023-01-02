resource "aws_sns_topic" "alarm_topic" {
  name = "alarm_topic"
}

resource "aws_sns_topic_subscription" "email-target" {
  topic_arn = aws_sns_topic.alarm_topic.arn
  protocol  = "email"
  endpoint  = var.alerting_email
}
