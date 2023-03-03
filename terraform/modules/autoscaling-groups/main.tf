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
  availability_zones = ["eu-west-1a", "eu-west-1b"]
  desired_capacity   = 0
  max_size           = 2
  min_size           = 0

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
}
