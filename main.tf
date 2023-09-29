terraform {
  required_providers {
    dockerhub = {
      source = "BarnabyShearer/dockerhub"
      version = ">= 0.0.15"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = "3.0.2"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "dockerhub" {
        username = "starseizer45"
        password = "Qazwsxedc45$"
}

resource "docker_image" "my_image" {
  name         = "starseizer45/packerprojects:latest"
  keep_locally = false
}

provider "aws" {
    region = "us-east-2"
}

resource "aws_instance" "dockerpacker_image" {
    ami = "ami-0430580de6244e02e"
    instance_type = "t2.micro"
    user_data = <<-EOF
    #!/bin/bash
    docker run -d starseizer45/packerprojects:latest
    EOF
}
