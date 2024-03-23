data "aws_availability_zones" "available" {
  state = "available" # Ensures you only get zones where you can actually launch resources
}