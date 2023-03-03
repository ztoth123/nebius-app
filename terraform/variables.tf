variable "cidr_block_vpc" {
  type    = string
  default = ""
}

variable "vpc_subnets" {
  description = "Map of subnet parameters."
  type        = map(any)
  default     = {}
}
