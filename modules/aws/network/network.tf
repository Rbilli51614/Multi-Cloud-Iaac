variable "vpc_cidr" { type = string }
variable "region" { type = string }# Get all available AZs in the region
data "aws_availability_zones" "available" {
  state = "available"
}
# Example: public subnets
variable "public_subnets" {
  type    = list(string)
  default = ["10.10.1.0/24", "10.10.2.0/24"]
} 
# Create subnets dynamically across AZs
resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.public_subnets : cidr => idx }

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.key
  availability_zone       = data.aws_availability_zones.available.names[tonumber(each.value)]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-${each.key}"
  }
}
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = { Name = "multi-iac-aws-vpc" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
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
