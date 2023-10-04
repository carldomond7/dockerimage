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
        password = ""
}

resource "docker_image" "my_image" {
  name         = "starseizer45/packerprojects:latest"
  keep_locally = false
}

provider "aws" {
    region = "us-east-2"
}
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
  name = "name"
  values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
  name = "virtualization-type"
  values = ["hvm"]
  }
owners = ["099720109477"]
}

resource "aws_instance" "dockerpacker_image" {
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    user_data = "${file("user_data.sh")}"
}
