#!/bin/bash


#Installing Docker

sudo apt-get update && sudo apt-get upgrade -y

sudo apt install docker.io -y

#Creating container

sudo docker run -d -p 8080:1234 annelaure42/brief14myappdevops
