resource "aws_vpc" "main" {
  cidr_block = var.cidr_block_vpc
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_block_subnet_1
  availability_zone = var.availability_zone_subnet_1
  tags = {
    Name = var.subnet_tag_1
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.cidr_block_subnet_2
  availability_zone = var.availability_zone_subnet_2
  tags = {
    Name = var.subnet_tag_2
  }
}

resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id
}



resource "aws_security_group" "alb-sg" {
  name        = "alb-sg"
  description = "Allow HTTP inbound and outbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "HTTP from Internet"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description      = "ANY to VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

}

resource "aws_security_group" "vm-sg" {
  name        = "vm-sg"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
  }

  egress {
    description      = "ANY to Internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}
