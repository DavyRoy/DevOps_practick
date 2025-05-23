output "container_name" {
  value = docker_container.web-nginx.name
}

output "container_id" {
  value = docker_container.web-nginx.id
}

output "container_ip" {
  value = docker_container.web-nginx.ip_address
}

output "container_image" {
  value = docker_container.web-nginx.image
}
