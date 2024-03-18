# WE_cloudTask
Repositorio dedicado al Trabajo de Cloud propuesto en el Bootcamp DevOps de WebExperto.

El objetivo del trabajo es integrar los conocimientos adquiridos durante el bootcamp para levantar una máquina virtual en Digital Ocean, configurarla y ejecutar una aplicación dockerizada.

Tecnologías utilizadas:
- Ubuntu Server
- SSH
- Bash scripting
- Docker
- Docker Compose
- Nginx
- Certificados SSL de LetsEncrypt
- Hostname en https://my.noip.com

Repositorio de la aplicación:
https://github.com/ColoCepeda/tup-lc2-votacion-app.git

Instrucciones:
- Crear una máquina virtual en Digital Ocean.
- Conectarse a la VM mediante SSH.
- Clonar este mismo repositorio.
- Ejecutar el script setup.sh.
- Completar los datos de los usuarios solicitados por el script setup.sh.
- Clonar el repositorio de la aplicación.
- Crear un archivo de configuración de Nginx para la aplicación con el user nginx.
- Crear un Hostname que apunte a la IP del repositorio en https://my.noip.com
- Servir la aplicación con Nginx en el puerto 80 con redirección automática al puerto 443 con certificados SSL usando el archivo docker-compose.yaml de este   repositorio(Modificado del repositorio: https://github.com/pablokbs/peladonerd.git).
