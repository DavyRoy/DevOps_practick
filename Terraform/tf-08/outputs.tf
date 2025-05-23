output "nginx_image_name" {
  value = data.docker_image.nginx.name
}

output "nginx_image_id" {
  value = data.docker_image.nginx.id
}

output "container_ip" {
  value = docker_container.nginx.network_data[0].ip_address
}
