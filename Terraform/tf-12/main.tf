variable "containers" {
  default = {
    "frontend" = 8081
    "backend"  = 8092
  }
}

resource "docker_container" "nginx" {
  for_each = var.containers

  name  = each.key
  image = "nginx:latest"

  lifecycle {
    prevent_destroy = each.key == "frontend" ? true : false
    ignore_changes  = [image]
  }

  ports {
    internal = 80
    external = each.value
  }
}

resource "null_resource" "wait_for_frontend" {
  depends_on = [docker_container.nginx["frontend"]]

  provisioner "local-exec" {
    command = "echo 'Frontend container is ready'"
  }
}
