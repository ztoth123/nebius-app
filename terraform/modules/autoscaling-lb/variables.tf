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

variable "page1_desired_capacity" {
  description = "Number of Amazon EC2 instances that should be running in the group"
  type    = number
}

variable "page1_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type    = number
}

variable "page1_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type    = number
}

variable "page2_desired_capacity" {
  description = "Number of Amazon EC2 instances that should be running in the group"
  type    = number
}

variable "page2_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type    = number
}

variable "page2_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type    = number
}
