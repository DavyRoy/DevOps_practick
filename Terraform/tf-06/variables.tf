variable "nginx_image" {
  type    = string
  default = "nginx:latest"
}

variable "nginx_name" {
  type    = string
  default = "web-nginx-06"
}

variable "nginx_port" {
  type    = number
  default = 8083
}
