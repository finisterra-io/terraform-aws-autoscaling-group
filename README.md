
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.65.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.65.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_autoscaling_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_policy) | resource |
| [aws_cloudwatch_metric_alarm.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |
| [aws_launch_configuration.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_subnet.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_asg_name"></a> [asg\_name](#input\_asg\_name) | The name of the Auto Scaling group. If you do not specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the group name. For more information, see Name Type. | `string` | n/a | yes |
| <a name="input_autoscaling_group_tags"></a> [autoscaling\_group\_tags](#input\_autoscaling\_group\_tags) | A map of tags to assign to the autoscaling group | `list(map(any))` | `[]` | no |
| <a name="input_autoscaling_policies"></a> [autoscaling\_policies](#input\_autoscaling\_policies) | Map of autoscaling policies to create | `map(any)` | `{}` | no |
| <a name="input_aws_cloudwatch_metric_alarms"></a> [aws\_cloudwatch\_metric\_alarms](#input\_aws\_cloudwatch\_metric\_alarms) | Map of CloudWatch metric alarms to create | `map(any)` | `{}` | no |
| <a name="input_capacity_rebalance"></a> [capacity\_rebalance](#input\_capacity\_rebalance) | Indicates whether capacity rebalance is enabled. Otherwise, capacity rebalance is disabled. | `bool` | `false` | no |
| <a name="input_create_aws_launch_configuration"></a> [create\_aws\_launch\_configuration](#input\_create\_aws\_launch\_configuration) | Create a launch configuration for the workspace | `bool` | `false` | no |
| <a name="input_default_cooldown"></a> [default\_cooldown](#input\_default\_cooldown) | The amount of time, in seconds, after a scaling activity completes before another scaling activity can start | `number` | `300` | no |
| <a name="input_desired_capacity"></a> [desired\_capacity](#input\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group, if not set will use `min_size` as value | `number` | `null` | no |
| <a name="input_ebs_block_device"></a> [ebs\_block\_device](#input\_ebs\_block\_device) | The ebs block device configuration of the launch template | `list(map(any))` | `[]` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | If true, the launched EC2 instance will be EBS-optimized | `bool` | `false` | no |
| <a name="input_enable_monitoring"></a> [enable\_monitoring](#input\_enable\_monitoring) | Enable/disable detailed monitoring | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to `false` to prevent the module from creating any resources | `bool` | `true` | no |
| <a name="input_enabled_metrics"></a> [enabled\_metrics](#input\_enabled\_metrics) | A list of metrics to collect. The allowed values are `GroupMinSize`, `GroupMaxSize`, `GroupDesiredCapacity`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupTerminatingInstances`, `GroupTotalInstances` | `list(string)` | `[]` | no |
| <a name="input_ephemeral_block_device"></a> [ephemeral\_block\_device](#input\_ephemeral\_block\_device) | The ephemeral block device configuration of the launch template | `list(map(any))` | `[]` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling | `bool` | `null` | no |
| <a name="input_health_check_grace_period"></a> [health\_check\_grace\_period](#input\_health\_check\_grace\_period) | Time (in seconds) after instance comes into service before checking health | `number` | `300` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | Controls how health checking is done. Valid values are `EC2` or `ELB` | `string` | `"EC2"` | no |
| <a name="input_iam_instance_profile_name"></a> [iam\_instance\_profile\_name](#input\_iam\_instance\_profile\_name) | The IAM instance profile name to associate with launched instances | `string` | `""` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The EC2 image ID to launch | `string` | `""` | no |
| <a name="input_instance_refresh"></a> [instance\_refresh](#input\_instance\_refresh) | The instance refresh definition | <pre>object({<br>    strategy = string<br>    preferences = optional(object({<br>      instance_warmup              = optional(number, null)<br>      min_healthy_percentage       = optional(number, null)<br>      skip_matching                = optional(bool, null)<br>      auto_rollback                = optional(bool, null)<br>      scale_in_protected_instances = optional(string, null)<br>      standby_instances            = optional(string, null)<br>    }), null)<br>    triggers = optional(list(string), [])<br>  })</pre> | `null` | no |
| <a name="input_instance_reuse_policy"></a> [instance\_reuse\_policy](#input\_instance\_reuse\_policy) | If warm pool and this block are configured, instances in the Auto Scaling group can be returned to the warm pool on scale in. The default is to terminate instances in the Auto Scaling group when the group scales in. | <pre>object({<br>    reuse_on_scale_in = bool<br>  })</pre> | `null` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type to launch | `string` | `null` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | The SSH key name that should be used for the instance | `string` | `""` | no |
| <a name="input_launch_configuration_name"></a> [launch\_configuration\_name](#input\_launch\_configuration\_name) | The name of the launch configuration. If you do not specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the group name. For more information, see Name Type. | `string` | `null` | no |
| <a name="input_launch_template"></a> [launch\_template](#input\_launch\_template) | The name of the launch template to use for the group. Conflicts with `launch_configuration`. | `list(any)` | `[]` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | A list of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use `target_group_arns` instead | `list(string)` | `[]` | no |
| <a name="input_max_instance_lifetime"></a> [max\_instance\_lifetime](#input\_max\_instance\_lifetime) | The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds | `number` | `null` | no |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the autoscale group | `number` | n/a | yes |
| <a name="input_metrics_granularity"></a> [metrics\_granularity](#input\_metrics\_granularity) | The granularity to associate with the metrics to collect. The only valid value is 1Minute | `string` | `"1Minute"` | no |
| <a name="input_min_elb_capacity"></a> [min\_elb\_capacity](#input\_min\_elb\_capacity) | Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes | `number` | `null` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the autoscale group | `number` | n/a | yes |
| <a name="input_mixed_instances_policy"></a> [mixed\_instances\_policy](#input\_mixed\_instances\_policy) | Policy to use a mixed group of on-demand/spot of differing types. Launch template is automatically generated. | <pre>list(object({<br>    instances_distribution = list(object({<br>      on_demand_allocation_strategy            = optional(string)<br>      on_demand_base_capacity                  = optional(number)<br>      on_demand_percentage_above_base_capacity = optional(number)<br>      spot_allocation_strategy                 = optional(string)<br>      spot_instance_pools                      = optional(number)<br>      spot_max_price                           = optional(string)<br>    }))<br>    launch_template = list(object({<br>      launch_template_specification = list(object({<br>        launch_template_id   = optional(string)<br>        launch_template_name = optional(string)<br>        version              = optional(string)<br>      }))<br>      override = list(object({<br>        instance_type     = optional(string)<br>        weighted_capacity = optional(string)<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_placement_group"></a> [placement\_group](#input\_placement\_group) | The name of the placement group into which you'll launch your instances, if any | `string` | `""` | no |
| <a name="input_placement_tenancy"></a> [placement\_tenancy](#input\_placement\_tenancy) | The tenancy of the instance. Valid values are `default` or `dedicated` | `string` | `""` | no |
| <a name="input_protect_from_scale_in"></a> [protect\_from\_scale\_in](#input\_protect\_from\_scale\_in) | Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events | `bool` | `false` | no |
| <a name="input_root_block_device"></a> [root\_block\_device](#input\_root\_block\_device) | The root block device configuration of the launch template | `map(any)` | `{}` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | A list of associated security group IDs | `list(string)` | `[]` | no |
| <a name="input_service_linked_role_arn"></a> [service\_linked\_role\_arn](#input\_service\_linked\_role\_arn) | The ARN of the service-linked role that the ASG will use to call other AWS services | `string` | `""` | no |
| <a name="input_spot_price"></a> [spot\_price](#input\_spot\_price) | The maximum price per unit hour that you are willing to pay for a Spot Instance. If you leave the value at its default (empty), AWS uses the On-Demand price as the maximum price. | `string` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A list of subnet IDs to launch resources in | `list(string)` | `null` | no |
| <a name="input_subnet_names"></a> [subnet\_names](#input\_subnet\_names) | A list of subnet names to launch resources in | `list(string)` | `[]` | no |
| <a name="input_suspended_processes"></a> [suspended\_processes](#input\_suspended\_processes) | A list of processes to suspend for the AutoScaling Group. The allowed values are `Launch`, `Terminate`, `HealthCheck`, `ReplaceUnhealthy`, `AZRebalance`, `AlarmNotification`, `ScheduledActions`, `AddToLoadBalancer`. Note that if you suspend either the `Launch` or `Terminate` process types, it can prevent your autoscaling group from functioning properly. | `list(string)` | `[]` | no |
| <a name="input_target_group_arns"></a> [target\_group\_arns](#input\_target\_group\_arns) | A list of aws\_alb\_target\_group ARNs, for use with Application Load Balancing | `list(string)` | `[]` | no |
| <a name="input_termination_policies"></a> [termination\_policies](#input\_termination\_policies) | A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are `OldestInstance`, `NewestInstance`, `OldestLaunchConfiguration`, `ClosestToNextInstanceHour`, `Default` | `list(string)` | `[]` | no |
| <a name="input_user_data_base64"></a> [user\_data\_base64](#input\_user\_data\_base64) | The Base64-encoded user data to provide when launching the instances | `string` | `""` | no |
| <a name="input_wait_for_capacity_timeout"></a> [wait\_for\_capacity\_timeout](#input\_wait\_for\_capacity\_timeout) | A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior | `string` | `null` | no |
| <a name="input_wait_for_elb_capacity"></a> [wait\_for\_elb\_capacity](#input\_wait\_for\_elb\_capacity) | Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over `min_elb_capacity` behavior | `number` | `null` | no |
| <a name="input_warm_pool"></a> [warm\_pool](#input\_warm\_pool) | If this block is configured, add a Warm Pool to the specified Auto Scaling group. See [warm\_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group#warm_pool). | <pre>object({<br>    pool_state                  = string<br>    min_size                    = number<br>    max_group_prepared_capacity = number<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_group_arn"></a> [autoscaling\_group\_arn](#output\_autoscaling\_group\_arn) | ARN of the AutoScaling Group |
| <a name="output_autoscaling_group_default_cooldown"></a> [autoscaling\_group\_default\_cooldown](#output\_autoscaling\_group\_default\_cooldown) | Time between a scaling activity and the succeeding scaling activity |
| <a name="output_autoscaling_group_desired_capacity"></a> [autoscaling\_group\_desired\_capacity](#output\_autoscaling\_group\_desired\_capacity) | The number of Amazon EC2 instances that should be running in the group |
| <a name="output_autoscaling_group_health_check_grace_period"></a> [autoscaling\_group\_health\_check\_grace\_period](#output\_autoscaling\_group\_health\_check\_grace\_period) | Time after instance comes into service before checking health |
| <a name="output_autoscaling_group_health_check_type"></a> [autoscaling\_group\_health\_check\_type](#output\_autoscaling\_group\_health\_check\_type) | `EC2` or `ELB`. Controls how health checking is done |
| <a name="output_autoscaling_group_id"></a> [autoscaling\_group\_id](#output\_autoscaling\_group\_id) | The AutoScaling Group id |
| <a name="output_autoscaling_group_max_size"></a> [autoscaling\_group\_max\_size](#output\_autoscaling\_group\_max\_size) | The maximum size of the autoscale group |
| <a name="output_autoscaling_group_min_size"></a> [autoscaling\_group\_min\_size](#output\_autoscaling\_group\_min\_size) | The minimum size of the autoscale group |
| <a name="output_autoscaling_group_name"></a> [autoscaling\_group\_name](#output\_autoscaling\_group\_name) | The AutoScaling Group name |
| <a name="output_autoscaling_group_tags"></a> [autoscaling\_group\_tags](#output\_autoscaling\_group\_tags) | A list of tag settings associated with the AutoScaling Group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
