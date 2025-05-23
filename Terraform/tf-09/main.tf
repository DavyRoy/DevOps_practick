module "nginx1" {
  source = "./modules/nginx"
  name   = "frontend"
  image  = "nginx:latest"
  external_port = 8086
}

module "nginx2" {
  source = "./modules/nginx"
  name   = "backand"
  image  = "nginx:latest"
  external_port = 8087
}
