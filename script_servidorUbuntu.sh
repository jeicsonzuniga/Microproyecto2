#!/bin/bash
echo "configurando el resolv.conf con cat"
cat <<TEST> /etc/resolv.conf
nameserver 8.8.8.8
TEST
#!------------------------------------------------------------
#!-Aprovicionando la maquina
#!------------------------------------------------------------
echo "Instalamos las herramientas de red"
sudo apt-get install net-tools
echo "Instalamos el gestor vim"
sudo apt-get install vim
echo "Instalamos lynx"
sudo apt-get install lynx -y
echo "Actualizamos los paquetes del sistema"
sudo apt-get update
echo "Instalamos python"
sudo apt install python3-pip -y
#!------------------------------------------------------------
#PARTE 2. Instalación de Docker en Ubuntu 22.04
#1.	Desinstalar versiones anteriores de Docker
sudo apt-get remove docker docker-engine docker.io containerd runc
#Actualizar el paquete apt e instale paquetes para permitir que apt use un repositorio a través de HTTPS
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
<< 'Comment'
sudo apt-get update
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common
Comment
#3. Agregue la clave GPG* oficial de Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#Verifique que tiene la clave con el fingerprint
sudo apt-key fingerprint 0EBFCD88
#4.	Agregar un repositorio stable
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu \ $(lsb_release -cs) \ stable"
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
#5.	Actualice el paquete apt e instale la última versión de Docker Engine.
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
#6.	Verifique que Docker Engine quedo instalado correctamente corriendo la imagen de hello-world
sudo docker run hello-world
#7.	Verificar que Docker esté corriendo
sudo systemctl status docker
#8.	Ver información de Docker
sudo docker info | more
#9.	Verificar qué imágenes de contenedores existen en los repositorios de docker. 
sudo docker search centos-ssh-apache
#10. Descargar imágenes
sudo docker pull jdeathe/centos-ssh-apache-php
#11. Ver imágenes descargadas
sudo docker images
#12. Ejecutar un contenedor basado en una de las imágenes descargadas
sudo docker run -d --name contenedorIA -p 8800:80 jdeathe/centos-ssh-apache-php
#!------------------------------------------------------------
#primero son los tag
# nombre de la imagen - nombre de repositorio hubdocker
#sudo docker tag jdeathe/centos-ssh-apache-php jeicson/contenedor.ia:v1
#sudo docker push jeicson/contenedor.ia:v1
#!------------------------------------------------------------
#13. Verificar qué contenedores están corriendo actualmente 
sudo docker ps
#Puede obtener una lista de todos los contenedores pasando el indicador -a al comando docker container ls:
sudo docker container ls -a
#sudo docker container stop 420e480dd15b
#sudo docker container rm 420e480dd15b
sudo docker container ls -a
#!------------------------------------------------------------
#PARTE 4. CREAR IMAGEN IA EN DOCKER
cd ~
sudo mkdir kubermatic-dl
cd kubermatic-dl
sudo cp /vagrant/app.py /home/vagrant/kubermatic-dl
sudo cp /vagrant/requirements.txt /home/vagrant/kubermatic-dl
sudo cp /vagrant/Dockerfile /home/vagrant/kubermatic-dl
sudo docker build -t kubermatic-dl:latest .
#sudo docker run --name webprueba -d -p 9000:80 omondragon/centosweb
sudo docker run --name imagenIA -d -p 5000:5000 kubermatic-dl
#!------------------------------------------------------------
#primero son los tag
# nombre de la imagen - nombre de repositorio hubdocker
#sudo docker tag jdeathe/centos-ssh-apache-php jeicson/imagen.ia:v1
#sudo docker push jeicson/imagen.ia:v1
#!------------------------------------------------------------
sudo docker ps -a
#!------------------------------------------------------------
# Azure - Azure - Azure - Azure - Azure - Azure - Azure - Azure
#!------------------------------------------------------------
#kubectl get service
#kubectl delete svc kubermatic-dl-deployment
#kubectl delete svc kubermatic-dl-deployment-contenedor-ia
#kubectl delete svc kubermatic-dl-deployment-imagen-ia
#!------------------------------------------------------------
#kubectl debug node/aks-agentpool-10523756-vmss000001 -it --image=mcr.microsoft.com/dotnet/runtime-deps:6.0
#mkdir contenedorIA
#touch deployment.yaml
#kubectl apply -f deployment.yaml
#kubectl expose deployment kubermatic-dl-deployment-contenedor-ia  --type=LoadBalancer --port 80 --target-port 5000
#!------------------------------------------------------------
# Azure - Azure - Azure - Azure - Azure - Azure - Azure - Azure
# kubectl get service
#!------------------------------------------------------------
#touch deployment.yaml
#kubectl apply -f deployment.yaml
#kubectl expose deployment kubermatic-dl-deployment-imagen-ia --type=LoadBalancer --port 80 --target-port 5000
#!------------------------------------------------------------
#https://stackoverflow.com/questions/47693911/how-to-delete-kubernetes-service

#sudo docker tag <your-image-id> <your-docker-hub-name>/<your-app-name>
#sudo docker push <your-docker-hub-name>/<your-app-name>
#kubectl get service
#kubectl logs kubermatic-dl-deployment2-84f8c98f6d-z2mz5
#kubectl get pods