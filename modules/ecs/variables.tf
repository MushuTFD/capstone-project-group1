
variable "name_prefix" {
  type = string
  default = ""
}

variable "service_type" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "ecr_repository_name" {
  type = string
}

variable "all_subnets" {
    type = list(string)
    description = "If it is a public subnet, provide the list of public subnet ids, if it is a private subnet, provide the lsit of private subnets"
    default = []
}

variable "public_or_private" {
  type = string
  description = "Defines the type to create in which subnet, either 'public' or 'private'"

  validation {
    condition = var.public_or_private == "public" || var.public_or_private == "private"
    error_message = "The variable public_or_private must be 'public' or 'private'."
  }
}

variable "container_port_mapping" {
  type = number
  description = "exposed port of the container"
}

variable "attach_lb_bool" {
  type = bool
  default = false
}

variable "target_group_arn" {
  type = string
  default = ""
}