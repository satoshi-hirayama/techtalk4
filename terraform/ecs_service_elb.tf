# IAM role
resource "aws_iam_role" "ecs_service" {
    name = "${var.base_name}_ecs"
    assume_role_policy = "${file("ecs_role.json")}"
}

resource "aws_iam_role_policy" "ecs_service" {
  name = "${var.base_name}_ecs_policy"
  policy = "${file("ecs_service_role.json")}"
  role = "${aws_iam_role.ecs_service.id}"
}

# Service
resource "aws_ecs_service" "service" {
  cluster = "${aws_ecs_cluster.ecs.id}"
  name = "${var.base_name}"
  depends_on = ["aws_iam_role_policy.ecs_service"]
  desired_count = 1
  iam_role = "${aws_iam_role.ecs_service.arn}"
  load_balancer {
    elb_name = "${aws_elb.elb.name}"
    container_name = "${var.base_name}"
    container_port = 80
  }
  task_definition = "${aws_ecs_task_definition.task_definition.arn}"
}
