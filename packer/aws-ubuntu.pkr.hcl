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
  region        = "us-west-2"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-xenial-22.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["self"]
  }
  ssh_username = "nebius"
  tags = {
      OS_Version = "Ubuntu"
      Release = "Latest"
      Base_AMI_Name = "{{ .SourceAMIName }}"
      Extra = "{{ .SourceAMITags.TagName }}"
  }
}

build {
  name = "nebius-packer"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "file" {
    destination = "/root/"
    sources     = [
      "./page1.html",
      "./page2.html"
    ]
  }

  provisioner "shell" {
    inline = [
      "echo Installing NGINX",
      "sleep 5",
      "sudo apt-get update",
      "sudo apt-get install -y nginx"
    ]
  }
}
