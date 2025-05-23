module "nginx1" {
  source = "./modules/nginx"
  name   = "frontend_new"
  image  = "nginx:latest"
  external_port = 8088
}

module "nginx2" {
  source = "./modules/nginx"
  name   = "backand_new"
  image  = "nginx:latest"
  external_port = 8089
}
