data "docker_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_container" "nginx" {
  name  = "nginx"
  image = data.docker_image.nginx.name

  ports {
    internal = 80
    external = var.base_port
  }
}
