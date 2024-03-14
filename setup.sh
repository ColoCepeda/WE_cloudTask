#!/bin/bash

# Configuración inicial para Ubuntu Server en DigitalOcean para el Bootcamp de DevOps de Web-Experto
# Autor: Marcelo Cepeda - Estudiante - marcelo.cepeda17@gmail.com


# Función para crear usuarios.
crear_usuario() {
    local user="$1"
    echo "Creando usuario '$user'..."
    if id "$user" &>/dev/null; then
        echo "El usuario $user ya existe"
    else
        while true; do
            read -s -p "Ingrese la contraseña para el usuario $user:  " pass
            echo -e "\n"
            read -s -p "Confirme contraseña: " pass2
            echo -e "\n"
            if [ "$pass" == "$pass2" ]; then
                break
            else
                echo "Las contraseñas no coinciden, inténtelo de nuevo."
            fi
        done

        useradd -m "$user"
        echo "$user:$pass" | chpasswd
        echo "El usuario $user fue creado exitosamente."
    fi
}

echo "Inicia setup para ubuntu server..."

#Actualizar dependencias
apt update

#1- Configurar zona horaria en Argentina

echo "Configurando zona horaria Argentina..."
apt -y install ntp
timedatectl set-timezone America/Argentina/Buenos_Aires

#2- Configurar nombre del host como "bootcampwebexperto"

echo "Cambiando hostname..."
hostnamectl set-hostname bootcampwebexperto

#3- Crear usuario sudo llamado "webexpertosudo"

crear_usuario "webexpertosudo"
usermod -aG sudo webexpertosudo

#4- Crear un user para conectarse via ssh

crear_usuario webexpertossh

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

crear_usuario nginx
usermod -aG docker nginx
