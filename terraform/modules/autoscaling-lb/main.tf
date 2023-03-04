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
cp /home/ubuntu/${var.page1_html} /var/www/html/index.html
EOF
  userdata_2 = <<EOF
#!/bin/bash
cp /home/ubuntu/${var.page2_html} /var/www/html/index.html
EOF

}

resource "aws_launch_template" "ubuntu-linux_1" {
  name          = "ubuntu-linux-lt_1"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data     = base64encode(local.userdata_1)
}

resource "aws_launch_template" "ubuntu-linux_2" {
  name          = "ubuntu-linux-lt_2"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data     = base64encode(local.userdata_2)
}

resource "aws_autoscaling_group" "twozones_ag_1" {
  vpc_zone_identifier = [var.subnet1_id, var.subnet2_id]
  desired_capacity   = 2
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
  desired_capacity   = 2
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
  protocol    = "TCP"
  vpc_id     = var.vpc_id
}

resource "aws_lb_target_group" "alb_tg_2" {
  name        = "tf-alb-tg-2"
  target_type = "instance"
  port        = 80
  protocol    = "TCP"
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
