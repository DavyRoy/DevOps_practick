terraform {
    required_providers {
        docker = {
        source  = "kreuzwerker/docker"
        version = "~> 2.25.0" # или latest на момент установки
        }
    }
}

provider "docker" {
    host = "unix:///var/run/docker.sock"
}
