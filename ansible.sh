#!/bin/bash 

# Install Ansible repository.
apt -y update && sudo apt-get -y upgrade
apt -y install sudo && apt-get -y install sudo
sudo apt -y install software-properties-common
sudo apt-add-repository ppa:ansible/ansible

# Install Ansible.
sudo apt -y update
sudo apt -y install ansible
