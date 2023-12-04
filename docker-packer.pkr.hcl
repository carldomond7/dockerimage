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
        sources = [
        "source.docker.docker-image"
        ]  
    provisioner "shell" {
        script = "./ansible.sh"
    }

    provisioner "ansible" {
        playbook_file = "./playbook_web.yml"
        ansible_env_vars = ["ANSIBLE_VERBOSITY=4"]
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
