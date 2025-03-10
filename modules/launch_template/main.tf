resource "aws_launch_template" "presentation_tier_lt" {
  name = "presentation_tier_lt"
  image_id = var.image_id
   instance_type = var.instance_type
   key_name = var.key_pair
   user_data = base64encode(file("${path.module}/userdata.sh"))
    network_interfaces {
    associate_public_ip_address = true  # Bật IP Public
    security_groups = var.security_group_presentation_tier_lt
  }
}

resource "aws_autoscaling_group" "presentation_tier_asg" {
  name = "presentation_tier_asg"
  max_size = 3
  min_size = 1
  desired_capacity = 2
  health_check_grace_period = 300
  target_group_arns = var.taget_group_arns
  health_check_type = "ELB"
  vpc_zone_identifier = var.subnet_ids
  launch_template {
    id = aws_launch_template.presentation_tier_lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "autoscaling_group"
    propagate_at_launch = true
  }
    enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
}

resource "aws_autoscaling_policy" "target_tracking_policy" {
  name                   = "target-tracking-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.presentation_tier_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"  # Điều chỉnh theo CPU trung bình của nhóm ASG
    }

    target_value = 50.0  
  }
}

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//application tier
resource "aws_launch_template" "application_tier_lt" {
  name = "application_tier_lt"
  image_id = var.image_id
   instance_type = var.instance_type
   key_name = var.key_pair
   user_data = base64encode(file("${path.module}/application.sh"))
    network_interfaces {
    associate_public_ip_address = false  # Bật IP Public
    security_groups = var.security_group_application_tier_lt//application tier ec2 security group
  }
}
resource "aws_autoscaling_group" "application_tier_asg" {
  name = "application_tier_asg"
  max_size = 3
  min_size = 1
  desired_capacity = 2
  health_check_grace_period = 300
  target_group_arns = var.taget_group_arns_application
  health_check_type = "ELB"
  vpc_zone_identifier = var.subnet_ids_application
  launch_template {
    id = aws_launch_template.application_tier_lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "autoscaling_group"
    propagate_at_launch = true
  }
    enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"
}

resource "aws_autoscaling_policy" "target_tracking_policy_application" {
  name                   = "target_tracking_policy_application"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.application_tier_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"  # Điều chỉnh theo CPU trung bình của nhóm ASG
    }

    target_value = 50.0  
  }
}
  