resource "aws_ecs_service" "notejam" {
  name            = "notejam"
  cluster         = "${aws_ecs_cluster.notejam.id}"
  task_definition = "${aws_ecs_task_definition.notejam.arn}"
  desired_count   = 1
  iam_role        = "${aws_iam_role.notejam.arn}"
  depends_on      = ["aws_iam_role_policy.policy"]

  placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    elb_name       = "${aws_elb.notejam.name}"
    container_name = "notejam"
    container_port = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [ap-northeast-1a, ap-northeast-1b, ap-northeast-1c]"
  }
}

