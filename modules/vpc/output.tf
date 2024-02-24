# Inside your module
output "common_tags" {
  value = local.letters
}

output "vpc_id" {
  value = aws_vpc.main.id
  description = "This is the VPC ID"
  
}

output "public_subnets" {
  value = aws_subnet.public.*.id
  description = "This is all the public subnets"
}