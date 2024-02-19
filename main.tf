module "vpc" {
  source = "./modules/vpc"

  cidr_block = "10.0.0.0/16"
  name_prefix = "sctp-ce4-group1"
  public_subnet_count = 3
  private_subnet_count = 3
  create_natgw = true
}

