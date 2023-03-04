variable "cidr_block_vpc" {
  type    = string
  default = ""
}

variable "cidr_block_subnet_1" {
  type    = string
  default = ""
}

variable "availability_zone_subnet_1" {
  type    = string
  default = ""
}

variable "cidr_block_subnet_2" {
  type    = string
  default = ""
}

variable "availability_zone_subnet_2" {
  type    = string
  default = ""
}

variable "page1_html" {
  description = "page1.html filename"
  type        = string
  default     = ""
}

variable "page2_html" {
  description = "page2.html filename"
  type        = string
  default     = ""
}

variable "page1_desired_capacity" {
  description = "Number of Amazon EC2 instances that should be running in the group"
  type        = number
}

variable "page1_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
}

variable "page1_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
}

variable "page2_desired_capacity" {
  description = "Number of Amazon EC2 instances that should be running in the group"
  type        = number
}

variable "page2_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
}

variable "page2_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
}
