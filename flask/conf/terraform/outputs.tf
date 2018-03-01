output "db_url" {
  value = "${aws_db_instance.default.address}"
}

output "ecr_repo" {
  value = "${aws_ecr_repository.notejam.repository_url}"
}
