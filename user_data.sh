#! /bin/bash
#Install Docker, first update apt package manager
sudo apt-get -y update
sudo apt-get install -y docker.io

#Start Docker Service
sudo systemctl start docker
sudo systemctl enable docker 

sudo docker run -d starseizer45/packerprojects:staraptor


