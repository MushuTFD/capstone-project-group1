locals {
  private_ingress_rule_list = ["http-8080-tcp","https-443-tcp","http-80-tcp"]
  public_ingress_rule_list = ["https-443-tcp","http-80-tcp"]
  ingress_rule_list = var.public_or_private == "public" ? local.public_ingress_rule_list : local.private_ingress_rule_list


  public_ip_needed = var.public_or_private == "public" ? true : null
}