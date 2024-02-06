variable "enabled" {
  type        = bool
  description = "Set to `false` to prevent the module from creating any resources"
  default     = true
}

variable "image_id" {
  type        = string
  description = "The EC2 image ID to launch"
  default     = ""
}

variable "instance_type" {
  type        = string
  description = "Instance type to launch"
  default     = null
}

variable "iam_instance_profile_name" {
  type        = string
  description = "The IAM instance profile name to associate with launched instances"
  default     = ""
}

variable "key_name" {
  type        = string
  description = "The SSH key name that should be used for the instance"
  default     = ""
}

variable "security_group_ids" {
  description = "A list of associated security group IDs"
  type        = list(string)
  default     = []
}

variable "user_data_base64" {
  type        = string
  description = "The Base64-encoded user data to provide when launching the instances"
  default     = ""
}

variable "enable_monitoring" {
  type        = bool
  description = "Enable/disable detailed monitoring"
  default     = true
}

variable "ebs_optimized" {
  type        = bool
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false
}

variable "instance_refresh" {
  description = "The instance refresh definition"
  type = object({
    strategy = string
    preferences = optional(object({
      instance_warmup              = optional(number, null)
      min_healthy_percentage       = optional(number, null)
      skip_matching                = optional(bool, null)
      auto_rollback                = optional(bool, null)
      scale_in_protected_instances = optional(string, null)
      standby_instances            = optional(string, null)
    }), null)
    triggers = optional(list(string), [])
  })

  default = null
}

variable "mixed_instances_policy" {
  description = "Policy to use a mixed group of on-demand/spot of differing types. Launch template is automatically generated."
  type = list(object({
    instances_distribution = list(object({
      on_demand_allocation_strategy            = optional(string)
      on_demand_base_capacity                  = optional(number)
      on_demand_percentage_above_base_capacity = optional(number)
      spot_allocation_strategy                 = optional(string)
      spot_instance_pools                      = optional(number)
      spot_max_price                           = optional(string)
    }))
    launch_template = list(object({
      launch_template_specification = list(object({
        launch_template_id   = optional(string)
        launch_template_name = optional(string)
        version              = optional(string)
      }))
      override = list(object({
        instance_type     = optional(string)
        weighted_capacity = optional(string)
      }))
    }))
  }))
  default = []
}

variable "max_size" {
  type        = number
  description = "The maximum size of the autoscale group"
}

variable "min_size" {
  type        = number
  description = "The minimum size of the autoscale group"
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
  default     = null
}

variable "default_cooldown" {
  type        = number
  description = "The amount of time, in seconds, after a scaling activity completes before another scaling activity can start"
  default     = 300
}

variable "health_check_grace_period" {
  type        = number
  description = "Time (in seconds) after instance comes into service before checking health"
  default     = 300
}

variable "health_check_type" {
  type        = string
  description = "Controls how health checking is done. Valid values are `EC2` or `ELB`"
  default     = "EC2"
}

variable "force_delete" {
  type        = bool
  description = "Allows deleting the autoscaling group without waiting for all instances in the pool to terminate. You can force an autoscaling group to delete even if it's in the process of scaling a resource. Normally, Terraform drains all the instances before deleting the group. This bypasses that behavior and potentially leaves resources dangling"
  default     = null
}

variable "load_balancers" {
  type        = list(string)
  description = "A list of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use `target_group_arns` instead"
  default     = []
}

variable "target_group_arns" {
  type        = list(string)
  description = "A list of aws_alb_target_group ARNs, for use with Application Load Balancing"
  default     = []
}

variable "termination_policies" {
  description = "A list of policies to decide how the instances in the auto scale group should be terminated. The allowed values are `OldestInstance`, `NewestInstance`, `OldestLaunchConfiguration`, `ClosestToNextInstanceHour`, `Default`"
  type        = list(string)
  default     = []
}

variable "suspended_processes" {
  type        = list(string)
  description = "A list of processes to suspend for the AutoScaling Group. The allowed values are `Launch`, `Terminate`, `HealthCheck`, `ReplaceUnhealthy`, `AZRebalance`, `AlarmNotification`, `ScheduledActions`, `AddToLoadBalancer`. Note that if you suspend either the `Launch` or `Terminate` process types, it can prevent your autoscaling group from functioning properly."
  default     = []
}

variable "placement_group" {
  type        = string
  description = "The name of the placement group into which you'll launch your instances, if any"
  default     = ""
}

variable "metrics_granularity" {
  type        = string
  description = "The granularity to associate with the metrics to collect. The only valid value is 1Minute"
  default     = "1Minute"
}

variable "enabled_metrics" {
  description = "A list of metrics to collect. The allowed values are `GroupMinSize`, `GroupMaxSize`, `GroupDesiredCapacity`, `GroupInServiceInstances`, `GroupPendingInstances`, `GroupStandbyInstances`, `GroupTerminatingInstances`, `GroupTotalInstances`"
  type        = list(string)

  default = []
}

variable "wait_for_capacity_timeout" {
  type        = string
  description = "A maximum duration that Terraform should wait for ASG instances to be healthy before timing out. Setting this to '0' causes Terraform to skip all Capacity Waiting behavior"
  default     = null
}

variable "min_elb_capacity" {
  type        = number
  description = "Setting this causes Terraform to wait for this number of instances to show up healthy in the ELB only on creation. Updates will not wait on ELB instance number changes"
  default     = null
}

variable "wait_for_elb_capacity" {
  type        = number
  description = "Setting this will cause Terraform to wait for exactly this number of healthy instances in all attached load balancers on both create and update operations. Takes precedence over `min_elb_capacity` behavior"
  default     = null
}

variable "protect_from_scale_in" {
  type        = bool
  description = "Allows setting instance protection. The autoscaling group will not select instances with this setting for terminination during scale in events"
  default     = false
}

variable "service_linked_role_arn" {
  type        = string
  description = "The ARN of the service-linked role that the ASG will use to call other AWS services"
  default     = ""
}

variable "desired_capacity" {
  type        = number
  description = "The number of Amazon EC2 instances that should be running in the group, if not set will use `min_size` as value"
  default     = null
}

variable "max_instance_lifetime" {
  type        = number
  default     = null
  description = "The maximum amount of time, in seconds, that an instance can be in service, values must be either equal to 0 or between 604800 and 31536000 seconds"
}

variable "capacity_rebalance" {
  type        = bool
  default     = false
  description = "Indicates whether capacity rebalance is enabled. Otherwise, capacity rebalance is disabled."
}

variable "warm_pool" {
  type = object({
    pool_state                  = string
    min_size                    = number
    max_group_prepared_capacity = number
  })
  description = "If this block is configured, add a Warm Pool to the specified Auto Scaling group. See [warm_pool](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group#warm_pool)."
  default     = null
}

variable "instance_reuse_policy" {
  type = object({
    reuse_on_scale_in = bool
  })
  description = "If warm pool and this block are configured, instances in the Auto Scaling group can be returned to the warm pool on scale in. The default is to terminate instances in the Auto Scaling group when the group scales in."
  default     = null
}

variable "asg_name" {
  type        = string
  description = "The name of the Auto Scaling group. If you do not specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the group name. For more information, see Name Type."
}

variable "autoscaling_policies" {
  type        = map(any)
  default     = {}
  description = "Map of autoscaling policies to create"
}

variable "launch_configuration_name" {
  type        = string
  description = "The name of the launch configuration. If you do not specify a name, AWS CloudFormation generates a unique physical ID and uses that ID for the group name. For more information, see Name Type."
  default     = null
}

variable "create_aws_launch_configuration" {
  type        = bool
  description = "Create a launch configuration for the workspace"
  default     = false
}

variable "spot_price" {
  type        = string
  description = "The maximum price per unit hour that you are willing to pay for a Spot Instance. If you leave the value at its default (empty), AWS uses the On-Demand price as the maximum price."
  default     = ""
}

variable "root_block_device" {
  type        = map(any)
  description = "The root block device configuration of the launch template"
  default     = {}
}

variable "ebs_block_device" {
  type        = list(map(any))
  description = "The ebs block device configuration of the launch template"
  default     = []
}

variable "ephemeral_block_device" {
  type        = list(map(any))
  description = "The ephemeral block device configuration of the launch template"
  default     = []
}

variable "placement_tenancy" {
  type        = string
  description = "The tenancy of the instance. Valid values are `default` or `dedicated`"
  default     = ""
}

variable "aws_cloudwatch_metric_alarms" {
  type        = map(any)
  default     = {}
  description = "Map of CloudWatch metric alarms to create"
}

variable "autoscaling_group_tags" {
  type        = list(map(any))
  description = "A map of tags to assign to the autoscaling group"
  default     = []
}

variable "subnet_names" {
  type        = list(string)
  description = "A list of subnet names to launch resources in"
  default     = []
}

variable "launch_template" {
  type        = list(any)
  description = "The name of the launch template to use for the group. Conflicts with `launch_configuration`."
  default     = []
}
