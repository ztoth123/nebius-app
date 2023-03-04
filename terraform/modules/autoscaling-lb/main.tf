data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self"]
}

locals {
  userdata_1 = <<EOF
#!/bin/bash
sudo cp /home/ubuntu/${var.page1_html} /var/www/html/page1.html
EOF
  userdata_2 = <<EOF
#!/bin/bash
sudo cp /home/ubuntu/${var.page2_html} /var/www/html/page2.html
EOF

}

resource "aws_launch_template" "ubuntu-linux_1" {
  name          = "ubuntu-linux-lt_1"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.sg-vm_id]
  user_data     = base64encode(local.userdata_1)
}

resource "aws_launch_template" "ubuntu-linux_2" {
  name          = "ubuntu-linux-lt_2"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.sg-vm_id]
  user_data     = base64encode(local.userdata_2)
}

resource "aws_autoscaling_group" "twozones_ag_1" {
  vpc_zone_identifier = [var.subnet1_id, var.subnet2_id]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  launch_template {
    id      = aws_launch_template.ubuntu-linux_1.id
    version = aws_launch_template.ubuntu-linux_1.latest_version
  }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }
  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }
  tag {
    key                 = "Owner"
    value               = "ZToth"
    propagate_at_launch = true
  }

}

resource "aws_autoscaling_group" "twozones_ag_2" {
  vpc_zone_identifier = [var.subnet1_id, var.subnet2_id]
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  launch_template {
    id      = aws_launch_template.ubuntu-linux_2.id
    version = aws_launch_template.ubuntu-linux_2.latest_version
  }
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }
  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }
  tag {
    key                 = "Owner"
    value               = "ZToth"
    propagate_at_launch = true
  }

}

resource "aws_lb_target_group" "alb_tg_1" {
  name        = "tf-alb-tg-1"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id     = var.vpc_id
}

resource "aws_lb_target_group" "alb_tg_2" {
  name        = "tf-alb-tg-2"
  target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id     = var.vpc_id
}

resource "aws_autoscaling_attachment" "asg_attachment_tg_1" {
  autoscaling_group_name = aws_autoscaling_group.twozones_ag_1.id
  lb_target_group_arn    = aws_lb_target_group.alb_tg_1.arn
}

resource "aws_autoscaling_attachment" "asg_attachment_tg_2" {
  autoscaling_group_name = aws_autoscaling_group.twozones_ag_2.id
  lb_target_group_arn    = aws_lb_target_group.alb_tg_2.arn
}

resource "aws_lb" "front_end_external" {
  name               = "aws-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg-alb_id]
  subnets            = [var.subnet1_id, var.subnet2_id]

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end_external.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_1.arn
  }
}

resource "aws_lb_listener_rule" "static_rule_1" {
  listener_arn = aws_lb_listener.front_end.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_1.arn
  }

  condition {
    path_pattern {
      values = ["/page1.html"]
    }
  }
}
resource "aws_lb_listener_rule" "static_rule_2" {
  listener_arn = aws_lb_listener.front_end.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg_2.arn
  }

  condition {
    path_pattern {
      values = ["/page2.html"]
    }
  }
}
