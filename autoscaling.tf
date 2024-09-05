resource "aws_autoscaling_policy" "this" {
  for_each           = var.autoscaling_policies
  name               = each.key
  enabled            = each.value.enabled
  scaling_adjustment = try(each.value.scaling_adjustment, 0)
  adjustment_type    = try(each.value.adjustment_type, "")
  policy_type        = each.value.policy_type
  cooldown           = each.value.cooldown
  # target_tracking_configuration
  dynamic "target_tracking_configuration" {
    for_each = try(each.value.target_tracking_configuration, [])
    content {
      predefined_metric_specification {
        predefined_metric_type = target_tracking_configuration.value.predefined_metric_specification.predefined_metric_type
        resource_label         = target_tracking_configuration.value.predefined_metric_specification.resource_label
      }
      target_value = target_tracking_configuration.value.target_value
    }
  }
  autoscaling_group_name = one(aws_autoscaling_group.default[*].name)
}

resource "aws_cloudwatch_metric_alarm" "this" {
  for_each                  = var.aws_cloudwatch_metric_alarms
  alarm_name                = each.key
  comparison_operator       = each.value.comparison_operator
  evaluation_periods        = each.value.evaluation_periods
  metric_name               = each.value.metric_name
  namespace                 = each.value.namespace
  period                    = each.value.period
  statistic                 = each.value.statistic
  extended_statistic        = each.value.extended_statistic
  threshold                 = each.value.threshold
  treat_missing_data        = each.value.treat_missing_data
  ok_actions                = each.value.ok_actions
  insufficient_data_actions = each.value.insufficient_data_actions
  dimensions = {
    (each.value.dimensions_name) = (each.value.dimensions_target)
  }

  alarm_description = each.value.alarm_description
  alarm_actions     = each.value.alarm_actions
  tags              = each.value.tags
}
