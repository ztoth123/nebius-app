packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "nebius-packer-linux-img"
  instance_type = "t2.micro"
  region        = "eu-west-1"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  ssh_username = "ubuntu"
  ssh_pty      = true
  tags = {
    OS_Version    = "Ubuntu"
    Release       = "Latest"
    Base_AMI_Name = "{{ .SourceAMIName }}"
    Owner         = "ZToth"
  }
}

build {
  name    = "nebius-packer"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "file" {
    destination = "/home/ubuntu/"
    sources = [
      "./page1.html",
      "./page2.html"
    ]
  }

  provisioner "shell" {
    inline = [
      "echo Installing NGINX",
      "pwd",
      "sudo apt update -y",
      "sudo apt install nginx -y"
    ]
  }
}
