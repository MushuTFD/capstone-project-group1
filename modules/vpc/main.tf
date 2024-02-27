# Create VPC first
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

# Create internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name_prefix}-igw"
  }
}

# Public subnet creation
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.main.id
  count = var.public_subnet_count
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index) #Dynamic assign the IP address in incremental order
  availability_zone = data.aws_availability_zones.available.names[count.index] #Dynamically create based on what is available

   map_public_ip_on_launch = true

   tags = {
    Name = "${var.name_prefix}-public-${format("%d", 1)}${local.letters[count.index]}"
   }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  count = var.public_subnet_count > 0 ? 1:0 #Conditional check to ensure that public subnet count is >0, then set to 1. Only need 1 RT table

  route {
    gateway_id = aws_internet_gateway.gw.id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "${var.name_prefix}-public-RT"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count = var.public_subnet_count > 0 ? var.public_subnet_count: 0
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public[0].id
}

# Private subnet creation
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  count = var.private_subnet_count
  cidr_block = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index + var.public_subnet_count) #Dynamic assign the IP address in incremental order
  availability_zone = data.aws_availability_zones.available.names[count.index] #Dynamically create based on what is available

   tags = {
    Name = "${var.name_prefix}-private-${format("%d", 1)}${local.letters[count.index]}"
   }
}

resource "aws_eip" "natgw" {
  count = var.create_natgw ? 1 : 0
  domain = "vpc"

  tags = {
    Name = "${var.name_prefix}-elastic-ip"
  }
}

resource "aws_nat_gateway" "natgw" {
  count = var.public_subnet_count > 0 && var.private_subnet_count > 0 && var.create_natgw ? 1 : 0
  allocation_id = aws_eip.natgw[0].id
  subnet_id = aws_subnet.public[0].id

  tags = {
    Name = "${var.name_prefix}-natgw"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  count = var.private_subnet_count > 0 ? 1:0 #Conditional check to ensure that public subnet count is >0, then set to 1. Only need 1 RT table

  route {
    gateway_id = aws_nat_gateway.natgw[0].id
    cidr_block = "0.0.0.0/0"
  }

  tags = {
    Name = "${var.name_prefix}-private-RT"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  count = var.private_subnet_count > 0 ? var.private_subnet_count: 0
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private[0].id
}