data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self"]
}

locals {
  userdata = <<EOF
#!/bin/bash
echo "Copying the ${var.pagehtml} file to /var/www/html/index.html"
cp ${var.pagehtml} /var/www/html/index.html
EOF
}

resource "aws_launch_template" "ubuntu-linux" {
  name          = "ubuntu-linux-lt"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data     = base64encode(local.userdata)
}

resource "aws_autoscaling_group" "twozones_ag" {
  vpc_zone_identifier = []
  desired_capacity   = 1
  max_size           = 2
  min_size           = 1
  launch_template {
    id      = aws_launch_template.ubuntu-linux.id
    version = aws_launch_template.ubuntu-linux.latest_version
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
}

resource "aws_lb_target_group" "alb_tg" {
  name        = "tf-alb-tg"
  target_type = "instance"
  port        = 80
  protocol    = "TCP"
  vpc_id     = var.vpc_id
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.twozones_ag.id
  lb_target_group_arn    = aws_lb_target_group.alb_tg.arn
}