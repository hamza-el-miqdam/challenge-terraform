locals {
  high_cpu_threshold    = 80
  high_memory_threshold = 80

  evaluation_periods = 3
  period             = 60 * 2 # 2 minutes
  service_dimensions = merge({
    "ClusterName" = aws_ecs_cluster.main.name
    }, {
    "ServiceName" = aws_ecs_service.main.name
  })
}

resource "aws_cloudwatch_metric_alarm" "high_cpu_usage" {
  # meta data
  alarm_name        = "${var.app_name}-high-cpu-usage"
  alarm_description = "Average CPU utilization was over ${local.high_cpu_threshold}% during the last ${local.evaluation_periods} period(s) of ${local.period} seconds"

  # metric query
  namespace   = "AWS/ECS"
  metric_name = "CPUUtilization"
  dimensions  = local.service_dimensions
  period      = local.period
  statistic   = "Average"

  # threshold
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = local.high_cpu_threshold
  evaluation_periods  = local.evaluation_periods
  treat_missing_data  = "missing"

  # actions
  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
}

resource "aws_cloudwatch_metric_alarm" "high_memory_usage" {
  # meta data
  alarm_name        = "${var.app_name}-high-memory-usage"
  alarm_description = "Average memory utilization was over ${local.high_memory_threshold}% during the last ${local.evaluation_periods} period(s) of ${local.period} seconds"

  # metric query
  namespace   = "AWS/ECS"
  metric_name = "MemoryUtilization"
  dimensions  = local.service_dimensions
  period      = local.period
  statistic   = "Average"

  # threshold
  comparison_operator = "GreaterThanOrEqualToThreshold"
  threshold           = local.high_memory_threshold
  evaluation_periods  = local.evaluation_periods
  treat_missing_data  = "missing"

  # actions
  alarm_actions = [aws_sns_topic.alarm_topic.arn]
  ok_actions    = [aws_sns_topic.alarm_topic.arn]
}
