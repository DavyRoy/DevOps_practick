locals {
  full_name = "${var.env}-${var.name}"
  internal_port = var.base_port + 1
}


resource "docker_container" "web-nginx-06" {
  name  = var.nginx_name
  image = var.nginx_image

  ports {
    internal = 80
    external = var.nginx_port
  }
}
