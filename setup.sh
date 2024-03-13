#!/bin/bash

# Configuración inicial para Ubuntu Server en DigitalOcean para el Bootcamp de DevOps de Web-Experto
# Autor: Marcelo Cepeda - Estudiante - marcelo.cepeda17@gmail.com

#Actualizar dependencias
apt update
apt upgrade -y

#1- Configurar zona horaria en Argentina

echo "Configurando zona horaria Argentina..."
apt -y install ntp
timedatectl set-timezone America/Argentina/Buenos_Aires

#2- Configurar nombre del host como "bootcampwebexperto"

echo "Cambiando hostname..."
hostnamectl set-hostname bootcampwebexperto

#3- Crear usuario sudo llamado "webexpertosudo"

echo "Creando usuario 'webexpertosudo'..."
adduser webexpertosudo
    #Agrego el usuario al grupo sudo para otorgar permisos
usermod -aG sudo webexpertosudo
echo "Usuario creado: webexpertosudo"

#4- Crear un user para conectarse via ssh

echo "Creando usuario para conexion via SSH..."
adduser webexpertossh
    #Agrego el usuario al grupo sudo para otorgar permisos
usermod -aG sudo webexpertossh
echo "Usuario creado: webexpertossh "

#5- Validar instalacion de docker e instalar

if docker info &> /dev/null; then
    echo "Docker ya está instalado."

else
    echo "Docker no está instalado. Iniciando la instalación..."
    apt-get install ca-certificates curl
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
    
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
       tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    echo "Docker se ha instalado correctamente."

fi

#6- Validar instalacion de docker-compose e instalar

if docker-compose version &> /dev/null; then
    echo "Docker-Compose esta instalado"

else
    echo "Docker-Compose no esta instalado. Iniciando la instalación..."
    apt-get install docker-compose-plugin
fi

#7- Crear grupo docker e iniciar el servicio

    #Crear grupo y añadir usuarios
groupadd docker
usermod -aG docker webexpertosudo
    #Iniciar el servicio de docker
systemctl start docker
    #Habilitar el inicio automatico de Docker
systemctl enable docker

#8- Instalar MC

echo "Instalando Midnight Commander..."
apt install mc

#9- Instalar Vim

echo "Instalando Vim..."
apt install vim

#10- Instalar Net-tools

echo "Instalando Net-Tools"
apt install net-tools


#11- Crear user nginx y dar permisos de docker

echo "Creando usuario nginx"

adduser nginx
usermod -aG docker nginx
usermod -aG sudo nginx

