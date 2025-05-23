resource "docker_container" "nginx" {
  name  = var.name
  image = var.image

  ports {
    internal = 80
    external = var.external_port
  }
}
