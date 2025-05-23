terraform {
  backend "local" {
    path = "backend/terraform.tfstate"
  }
}

module "nginx1" {
  source = "./modules/nginx"
  name   = "frontend_new_2"
  image  = "nginx:latest"
  external_port = 8090
}

module "nginx2" {
  source = "./modules/nginx"
  name   = "backand_new_2"
  image  = "nginx:latest"
  external_port = 8091
}
