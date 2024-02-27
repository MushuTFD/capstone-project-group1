variable "cidr_block" {
  type = string
  default = ""
}

variable "name_prefix" {
  type = string
  default = ""
}

variable "public_subnet_count" {
  type = number
  default = 0
}

variable "private_subnet_count" {
  type = number
  default = 0
}

variable "create_natgw" {
  type = bool
  default = true
}