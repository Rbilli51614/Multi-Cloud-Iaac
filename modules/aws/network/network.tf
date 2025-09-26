variable "vpc_cidr" { type = string }
variable "public_subnets" { type = list(string) }
variable "region" { type = string }

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = { Name = "multi-iac-aws-vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.public_subnets : idx => cidr }

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  map_public_ip_on_launch = true

  # spread subnets across AZs dynamically
  availability_zone = data.aws_availability_zones.available.names[each.key]

  tags = {
    Name = "public-${each.key}"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
  route { 
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.igw.id 
    }
}

resource "aws_route_table_association" "a" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

output "vpc_id" { value = aws_vpc.this.id }
output "public_subnet_ids" { value = [for s in aws_subnet.public : s.id] }