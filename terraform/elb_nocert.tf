# ELB
# Security Group (ELB)
resource "aws_security_group" "elb" {
  description = "${var.base_name} elb"
  egress {
    cidr_blocks = ["${var.cidr_all_node}"]
    from_port = 0
    protocol = "-1"
    to_port = 0
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
  name = "${var.base_name}_elb"
  tags {
    Name = "${var.base_name}_elb"
  }
  vpc_id = "${aws_vpc.vpc.id}"
}

resource "aws_elb" "elb" {
  connection_draining = true
  connection_draining_timeout = 300
  cross_zone_load_balancing = true
  health_check {
    healthy_threshold = 2
    interval = 30
    target = "HTTP:80${var.elb_health_check_endpoint}"
    timeout = 3
    unhealthy_threshold = 2
  }
  idle_timeout = 300
  instances = ["${aws_instance.app.id}"]
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }
  name = "${var.base_name_hyphen}-elb"
  subnets = ["${aws_subnet.public_1.id}", "${aws_subnet.public_2.id}"]
  security_groups = ["${aws_security_group.elb.id}"]
  tags {
    Name = "${var.base_name}_elb"
  }
}
