provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "${var.region}"
}

# 踏み台（Public Subnet）のSSH Key
resource "aws_key_pair" "key_pair_bastion" {
  key_name = "${var.base_name}_bastion"
  public_key = "${var.ec2_bastion_instance_ssh_public_key}"
}

# VPC
resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr_block}"
  tags {
    Name = "${var.base_name}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "internet_gateway" {
  tags {
    Name = "${var.base_name}"
  }
  vpc_id = "${aws_vpc.vpc.id}"
}

# Public Subnete 1
resource "aws_subnet" "public_1" {
  availability_zone = "${var.availability_zone_1}"
  cidr_block = "${var.public_subnet_1_cidr_block}"
  tags {
    Name = "${var.base_name}_public_1"
  }
  vpc_id = "${aws_vpc.vpc.id}"
}

# Private Subnet 1
resource "aws_subnet" "private_1" {
  availability_zone = "${var.availability_zone_1}"
  cidr_block = "${var.private_subnet_1_cidr_block}"
  tags {
    Name = "${var.base_name}_private_1"
  }
  vpc_id = "${aws_vpc.vpc.id}"
}

# Route Table (Public Subnet)
resource "aws_route_table" "public" {
  route {
    cidr_block = "${var.cidr_all_node}"
    gateway_id = "${aws_internet_gateway.internet_gateway.id}"
  }
  tags {
    Name = "${var.base_name}_public"
  }
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table_association" "public_1" {
  route_table_id = "${aws_route_table.public.id}"
  subnet_id = "${aws_subnet.public_1.id}"
}

# Security Group (Public Subnet)
resource "aws_security_group" "public" {
  description = "${var.base_name} public"
  egress {
    cidr_blocks = ["${var.cidr_all_node}"]
    from_port = 0
    protocol = "-1"
    to_port = 0
  }
  ingress {
    cidr_blocks = ["${var.cidr_ssh}"]
    from_port = 22
    protocol = "tcp"
    to_port = 22
  }
  ingress {
    cidr_blocks = ["${var.cidr_all_node}"]
    from_port = 20
    protocol = "tcp"
    to_port = 20
  }
  ingress {
    cidr_blocks = ["${var.cidr_all_node}"]
    from_port = 21
    protocol = "tcp"
    to_port = 21
  }
  ingress {
    cidr_blocks = ["${var.cidr_all_node}"]
    from_port = 22
    protocol = "tcp"
    to_port = 22
  }
  ingress {
    cidr_blocks = ["${var.cidr_all_node}"]
    from_port = 80
    protocol = "tcp"
    to_port = 80
  }
  ingress {
    cidr_blocks = ["${var.cidr_all_node}"]
    from_port = 443
    protocol = "tcp"
    to_port = 443
  }
  ingress {
    cidr_blocks = ["${var.cidr_all_node}"]
    from_port = 3128
    protocol = "tcp"
    to_port = 3128
  }
  name = "${var.base_name}_public"
  tags {
    Name = "${var.base_name}_public"
  }
  vpc_id = "${aws_vpc.vpc.id}"
}

# Security Group (Private Subnet)
resource "aws_security_group" "private" {
  description = "${var.base_name} private"
  egress {
    cidr_blocks = ["${var.cidr_all_node}"]
    from_port = 0
    protocol = "-1"
    to_port = 0
  }
  ingress {
    from_port = 22
    protocol = "tcp"
    security_groups = ["${aws_security_group.public.id}"]
    to_port = 22
  }
  ingress {
    from_port = 80
    protocol = "tcp"
    security_groups = ["${aws_security_group.elb.id}"]
    to_port = 80
  }
  name = "${var.base_name}_private"
  tags {
    Name = "${var.base_name}_private"
  }
  vpc_id = "${aws_vpc.vpc.id}"
}

# EC2 Instance (Bastion)
resource "aws_instance" "bastion" {
  ami = "${var.ec2_ami}"
  associate_public_ip_address = "true"
  availability_zone = "${var.availability_zone_1}"
  instance_type = "${var.ec2_bastion_instance_type}"
  key_name = "${var.base_name}_bastion"
  root_block_device = {
    volume_size = "${var.ec2_bastion_gp2_size}"
    volume_type = "gp2"
  }
  subnet_id = "${aws_subnet.public_1.id}"
  tags {
    Name = "${var.base_name}_bastion"
  }
  vpc_security_group_ids = ["${aws_security_group.public.id}"]
}

resource "aws_eip" "bastion" {
  instance = "${aws_instance.bastion.id}"
  vpc      = true
}
