/* data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self"]
}

output "vpc_all_tags" {
  value = aws_vpc.example.tags_all

variable "pagehtml" {
  description = "page1.html or page2.html filename"
  default = ""
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data = <<EOF
#!/bin/bash
echo "Copying the ${var.pagehtml} file to /var/www/html/index.html"
cp ${var.pagehtml} /var/www/html/index.html
EOF
  tags = {
    Name = "nebius-vm"
  }
}

output "instances" {
  value       = "${aws_instance.web.*.private_ip}"
  description = "PrivateIP address details"
}

output "vpc_all_tags" {
  value = aws_vpc.example.tags_all
} */