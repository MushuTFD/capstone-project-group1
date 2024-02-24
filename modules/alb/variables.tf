variable "vpc_id" {
    type = string
    default = ""
}

variable "prefix_name" {
    type = string
    default = ""
}

variable "all_subnets" {
    type = list(string)
    default = []
}