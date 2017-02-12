# IAM role
resource "aws_iam_role_policy" "ecs_instance" {
  name = "${var.base_name}_ecs_instance_policy"
  policy = "${file("ecs_cluster_instance.json")}"
  role = "${aws_iam_role.ecs_service.id}"
}

resource "aws_iam_instance_profile" "ecs_instance" {
  name = "${var.base_name}_ecs_instance_profile"
  path = "/"
  roles = ["${aws_iam_role.ecs_service.name}"]
}

# APP/Worker（Private Subnet）のSSH Key
resource "aws_key_pair" "key_pair" {
  key_name = "${var.base_name}"
  public_key = "${var.ec2_app_instance_ssh_public_key}"
}

# EC2 Instance (App)
resource "aws_instance" "app" {
  ami = "${var.ec2_ami}"
  associate_public_ip_address = "false"
  availability_zone = "${var.availability_zone_1}"
  iam_instance_profile = "${aws_iam_instance_profile.ecs_instance.id}"
  instance_type = "${var.ec2_app_instance_type}"
  key_name = "${var.base_name}"
  root_block_device = {
    volume_size = "${var.ec2_app_gp2_size}"
    volume_type = "gp2"
  }
  subnet_id = "${aws_subnet.private_1.id}"
  tags {
    Name = "${var.base_name}_app"
  }
  vpc_security_group_ids = ["${aws_security_group.private.id}"]
}
