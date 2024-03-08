resource "aws_instance" "main" {
  count = var.no_of_ec2 > 0 ? var.no_of_ec2 : 0
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  
  associate_public_ip_address = true
  subnet_id = var.public_subnet_ids[count.index]
  # Optional configurations
  # key_name = ""

  tags = {
    Name = "${var.name_prefix}-ec2-${count.index}"
  }
}