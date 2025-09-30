variable "subnet_id" { type = string }
variable "key_name"  { type = string }
variable "ingress_cidr_ssh" { type = string }

data "aws_ami" "al2" {
  most_recent = true
  owners      = ["amazon"]
<<<<<<< HEAD
  filter { 
    name = "name" 
    values = ["al2023-ami-*-x86_64"] 
    }
=======
  filter { name = "name" values = ["al2023-ami-*-x86_64"] }
>>>>>>> a240d67466d6af8db9b0490d6e6bdfe53929bc9e
}

resource "aws_security_group" "web" {
  name   = "sg-web"
  vpc_id = var.vpc_id
<<<<<<< HEAD
  ingress { 
    from_port=80 
    to_port=80 
    protocol="tcp" 
    cidr_blocks=["0.0.0.0/0"] 
    }
  ingress { 
    from_port=22 
    to_port=22 
    protocol="tcp" 
    cidr_blocks=[var.ingress_cidr_ssh] 
    }
  egress  { 
    from_port=0 
    to_port=0 
    protocol="-1" 
    cidr_blocks=["0.0.0.0/0"] 
    }
=======
  ingress { from_port=80 to_port=80 protocol="tcp" cidr_blocks=["0.0.0.0/0"] }
  ingress { from_port=22 to_port=22 protocol="tcp" cidr_blocks=[var.ingress_cidr_ssh] }
  egress  { from_port=0 to_port=0 protocol="-1" cidr_blocks=["0.0.0.0/0"] }
>>>>>>> a240d67466d6af8db9b0490d6e6bdfe53929bc9e
}

variable "vpc_id" { type = string }

resource "aws_instance" "web" {
  ami                         = data.aws_ami.al2.id
  instance_type               = "t3.micro"
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.web.id]
  user_data                   = file("${path.module}/../../../../scripts/bootstrap_aws.sh")
  tags = { Name = "aws-web" }
}

output "instance_id" { value = aws_instance.web.id }
output "instance_private_ip" { value = aws_instance.web.private_ip }
