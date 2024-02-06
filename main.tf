resource "aws_launch_configuration" "default" {
  count             = var.enabled && var.create_aws_launch_configuration ? 1 : 0
  name              = var.launch_configuration_name
  image_id          = var.image_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  user_data         = var.user_data_base64
  enable_monitoring = var.enable_monitoring
  ebs_optimized     = var.ebs_optimized
  # security_groups   = var.security_group_ids
  security_groups = var.security_group_ids


  dynamic "root_block_device" {
    for_each = length(var.root_block_device) > 0 ? [var.root_block_device] : []
    content {
      volume_type           = lookup(root_block_device.value, "volume_type", null)
      volume_size           = lookup(root_block_device.value, "volume_size", null)
      delete_on_termination = lookup(root_block_device.value, "delete_on_termination", null)
    }
  }

  dynamic "ebs_block_device" {
    for_each = var.ebs_block_device
    content {
      device_name           = lookup(ebs_block_device.value, "device_name", null)
      volume_type           = lookup(ebs_block_device.value, "volume_type", null)
      volume_size           = lookup(ebs_block_device.value, "volume_size", null)
      delete_on_termination = lookup(ebs_block_device.value, "delete_on_termination", null)
    }
  }

  dynamic "ephemeral_block_device" {
    for_each = var.ephemeral_block_device
    content {
      device_name  = lookup(ephemeral_block_device.value, "device_name", null)
      virtual_name = lookup(ephemeral_block_device.value, "virtual_name", null)

    }
  }

  iam_instance_profile = var.iam_instance_profile_name

  spot_price = var.spot_price

  placement_tenancy = var.placement_tenancy


  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "default" {
  count = var.enabled ? 1 : 0

  name                      = var.asg_name
  vpc_zone_identifier       = coalesce(var.subnet_ids, data.aws_subnet.default[*].id, [])
  max_size                  = var.max_size
  min_size                  = var.min_size
  load_balancers            = var.load_balancers
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  min_elb_capacity          = var.min_elb_capacity
  wait_for_elb_capacity     = var.wait_for_elb_capacity
  target_group_arns         = var.target_group_arns
  default_cooldown          = var.default_cooldown
  force_delete              = var.force_delete
  termination_policies      = var.termination_policies
  suspended_processes       = var.suspended_processes
  placement_group           = var.placement_group
  enabled_metrics           = var.enabled_metrics
  metrics_granularity       = var.metrics_granularity
  wait_for_capacity_timeout = var.wait_for_capacity_timeout
  protect_from_scale_in     = var.protect_from_scale_in
  service_linked_role_arn   = var.service_linked_role_arn
  desired_capacity          = var.desired_capacity
  max_instance_lifetime     = var.max_instance_lifetime
  capacity_rebalance        = var.capacity_rebalance

  dynamic "instance_refresh" {
    for_each = (var.instance_refresh != null ? [var.instance_refresh] : [])

    content {
      strategy = instance_refresh.value.strategy
      dynamic "preferences" {
        for_each = instance_refresh.value.preferences != null ? [instance_refresh.value.preferences] : []
        content {
          instance_warmup              = lookup(preferences.value, "instance_warmup", null)
          min_healthy_percentage       = lookup(preferences.value, "min_healthy_percentage", null)
          skip_matching                = lookup(preferences.value, "skip_matching", null)
          auto_rollback                = lookup(preferences.value, "auto_rollback", null)
          scale_in_protected_instances = lookup(preferences.value, "scale_in_protected_instances", null)
          standby_instances            = lookup(preferences.value, "standby_instances", null)
        }
      }
      triggers = instance_refresh.value.triggers
    }
  }

  launch_configuration = var.create_aws_launch_configuration ? aws_launch_configuration.default[0].name : null

  dynamic "launch_template" {
    for_each = var.launch_template
    content {
      id      = launch_template.value.id
      version = launch_template.value.version
    }
  }

  dynamic "mixed_instances_policy" {
    for_each = var.mixed_instances_policy
    content {
      dynamic "instances_distribution" {
        for_each = lookup(mixed_instances_policy.value, "instances_distribution", null) != null ? mixed_instances_policy.value.instances_distribution : []
        content {
          on_demand_allocation_strategy            = try(instances_distribution.value.on_demand_allocation_strategy, null)
          on_demand_base_capacity                  = try(instances_distribution.value.on_demand_base_capacity, null)
          on_demand_percentage_above_base_capacity = try(instances_distribution.value.on_demand_percentage_above_base_capacity, null)
          spot_allocation_strategy                 = try(instances_distribution.value.spot_allocation_strategy, null)
          spot_instance_pools                      = try(instances_distribution.value.spot_instance_pools, null)
          spot_max_price                           = try(instances_distribution.value.spot_max_price, null)
        }
      }
      dynamic "launch_template" {
        for_each = lookup(mixed_instances_policy.value, "launch_template", null) != null ? mixed_instances_policy.value.launch_template : []
        content {
          dynamic "launch_template_specification" {
            for_each = lookup(launch_template.value, "launch_template_specification", null) != null ? launch_template.value.launch_template_specification : []
            content {
              launch_template_id = try(launch_template_specification.value.launch_template_id, null)
              version            = try(launch_template_specification.value.version, null)
            }
          }
          dynamic "override" {
            for_each = lookup(launch_template.value, "override", null) != null ? launch_template.value.override : []
            content {
              instance_type     = try(override.value.instance_type, null)
              weighted_capacity = try(override.value.weighted_capacity, null)
            }
          }
        }
      }
    }
  }

  dynamic "warm_pool" {
    for_each = var.warm_pool != null ? [var.warm_pool] : []
    content {
      pool_state                  = try(warm_pool.value.pool_state, null)
      min_size                    = try(warm_pool.value.min_size, null)
      max_group_prepared_capacity = try(warm_pool.value.max_group_prepared_capacity, null)
      dynamic "instance_reuse_policy" {
        for_each = var.instance_reuse_policy != null ? [var.instance_reuse_policy] : []
        content {
          reuse_on_scale_in = instance_reuse_policy.value.reuse_on_scale_in
        }
      }
    }
  }

  dynamic "tag" {
    for_each = var.autoscaling_group_tags
    content {
      key                 = tag.value.key
      value               = tag.value.value
      propagate_at_launch = tag.value.propagate_at_launch
    }
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }
}
