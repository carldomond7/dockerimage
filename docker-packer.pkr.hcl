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

#Basically going to use this to give templates a unique name
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

    source "docker" "docker-image" {
    image = "ubuntu:xenial"
    commit = true
}

    build {
        source = [
        "source.docker.docker-image"
        ]
    provisioner "ansible" {
        playbook_file = "./playbook_web.yml"
        }
    }