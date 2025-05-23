resource "docker_container" "web-nginx" {
  name  = var.nginx_name
  image = var.nginx_image

  ports {
    internal = 80
    external = 8082
  }
}
