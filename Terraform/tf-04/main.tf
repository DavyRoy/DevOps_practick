resource "docker_container" "web-nginx" {
  name  = "web-nginx"
  image = "nginx:latest"

  ports {
    internal = 80
    external = 8081
  }

  env = ["NGINX_PORT=8081"]
  }
