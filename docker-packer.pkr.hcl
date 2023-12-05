packer {
    required_plugins {
        amazon = {
            version = ">= 1.2.6"
            source = "github.com/hashicorp/amazon"
        }
    }
}
packer {
    required_plugins {
        ansible = {
            version = ">= 1.1.0"
            source = "github.com/hashicorp/ansible"
        }
    }
}
packer {
    required_plugins {
        docker = {
            version = ">= 1.0.1"
            source = "github.com/hashicorp/docker"
        }
    }
}

#Initializing region variable
variable "region" {
    type = string
    default = "us-east-2"
}

variable "timezone" {
  default = "America/Pacific"
}


#Basically going to use this to give templates a unique name
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

 source "docker" "my_image" {
  image = "ubuntu:jammy"
  commit = true
  environment_vars = [
    "DEBIAN_FRONTEND=noninteractive",
    "TZ=${var.timezone}"
  ]
}

    build {
        sources = [
        "source.docker.docker-image"
        ]  
    provisioner "shell" {
        script = "./ansible.sh"
    }

    provisioner "ansible" {
        playbook_file = "./playbook_web.yml"
    }

    post-processors {
        post-processor "docker-tag" {
            repository = "starseizer45/packerprojects"
            tag = ["staraptor"]
        }
    post-processor "docker-push" {
            login = true
            login_username = "starseizer45"
            login_password = "$uper$ecret!"
        }
    }
}
