variable "vpc_id" {
    type = string
}

variable "name_prefix" {
    type = string
    default = ""
}

variable "all_subnets" {
    type = list(string)
    default = []
}

variable "service_type" {
    type = string
}
