

# Public Subnet 2
resource "aws_subnet" "public_2" {
  availability_zone = "${var.availability_zone_2}"
  cidr_block = "${var.public_subnet_2_cidr_block}"
  tags {
    Name = "${var.base_name}_public_2"
  }
  vpc_id = "${aws_vpc.vpc.id}"
}

# Route Table (Public Subnet)
resource "aws_route_table_association" "public_2" {
  route_table_id = "${aws_route_table.public.id}"
  subnet_id = "${aws_subnet.public_2.id}"
}

# Private Subnet 2
resource "aws_subnet" "private_2" {
  availability_zone = "${var.availability_zone_2}"
  cidr_block = "${var.private_subnet_2_cidr_block}"
  tags {
    Name = "${var.base_name}_private_2"
  }
  vpc_id = "${aws_vpc.vpc.id}"
}

# Route Table (Private Subnet)
resource "aws_route_table" "private_2" {
  route {
    cidr_block = "${var.cidr_all_node}"
    nat_gateway_id = "${aws_nat_gateway.nat_gateway_2.id}"
  }
  tags {
    Name = "${var.base_name}_private"
  }
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_route_table_association" "private_2" {
  route_table_id = "${aws_route_table.private_2.id}"
  subnet_id = "${aws_subnet.private_2.id}"
}

resource "aws_eip" "eip_2" {
 vpc = true
}

resource "aws_nat_gateway" "nat_gateway_2" {
 allocation_id = "${aws_eip.eip_2.id}"
 subnet_id = "${aws_subnet.public_2.id}"
}
