variable "page1_html" {
  description = "page1.html filename"
  default = ""
}

variable "page2_html" {
  description = "page2.html filename"
  default = ""
}

variable "vpc_id" {
  type    = string
  default = ""
}

variable "subnet1_id" {
  type = string
  default = ""
}

variable "subnet2_id" {
  type = string
  default = ""
}

variable "sg-alb_id" {
  type = string
  default = ""
}

variable "sg-vm_id" {
  type = string
  default = ""
}

variable "desired_capacity" {
  description = "Number of Amazon EC2 instances that should be running in the group"
  type    = number
}

variable "max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type    = number
}

variable "min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type    = number
}
