output "container_name" {
  value = docker_container.web-nginx-06.name
}

output "container_id" {
  value = docker_container.web-nginx-06.id
}

output "container_ip" {
  value = docker_container.web-nginx-06.ip_address
}

output "container_image" {
  value = docker_container.web-nginx-06.image
}
