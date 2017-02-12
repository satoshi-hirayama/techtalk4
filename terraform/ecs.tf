# ECS
# Cluster
resource "aws_ecs_cluster" "ecs" {
  name = "${var.base_name}"
}

# Task definition
resource "aws_ecs_task_definition" "task_definition" {
  container_definitions = "${file("ecs_service.json")}"
  family = "${var.base_name}"
}
