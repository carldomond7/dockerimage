terraform {
  required_providers {
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

provider "docker" {
  host = "tcp://${aws_instance.dockerpacker_image.public_ip}:2376"
}

resource "docker_image" "staraptor" {
  name = "starseizer45/packerprojects:staraptor"
}

resource "docker_container" "my_container" {
  image = docker_image.staraptor.name
  name  = "pokeball"
}
