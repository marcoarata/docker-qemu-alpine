## docker-qemu-alpine

# 📱 Instrucciones para Configurar Docker en dispositivos Android con Termux, Qemu y Alpine Linux x86_64 📱

• Instalar Termux (Terminal con Linux tipo FreeBSD para Android)

👉 Habilitar el modo de desarrollador de Android

👉 Descargar la tienda F-droid (https://f-droid.org/es/)

👉 Descargar la última versión de Termux desde F-droid "Termux Emulador de terminal con paquetes"

• Dar acceso a Temux al directorio de archivos compartidos

```bash
$ termux-setup-storage
```


## 🛠️ Instalar docker-qemu-alpine en Termux

```bash
$ apt update && apt upgrade -y
$ apt install git -y
$ git clone https://github.com/marcoarata/docker-qemu-alpine
$ cd docker-qemu-alpine
$ chmod +x termux-setup.sh
$ ./termux-setup.sh
```

⚠️ Al finalizar la instalación presionar ctrl+C o simplemente borrar el sobrante de la línea de comandos. ⚠️


## 🛠️ Configurar script de acceso

• Mover carpeta alpine a home desde la carpeta docker-qemu-alpine:

```bash
$ cd docker-qemu-alpine
$ mv alpine ..
```

👉 o simplemente si se esta en la ráiz (home):

```bash
$ mv docker-qemu-alpine/alpine .
```

⚠️ Opcionalmente se puede borrar la carpeta de instalación "docker-qemu-alpine" si ya no es necesaria.


## 🚀 Acceso automatizado a Alpine Linux con Script "qemu-alpine.sh"

```bash
$ cd alpine
$ ./qemu-alpine.sh
```

• Seleccionar una de las opciones del menú

 Selecciona una opción:
  1. Iniciar Alpine Linux con Contraseña
  2. Conéctate a tu sesión de Alpine Linux usando SSH
  3. Redirigir un puerto desde Termux hacia un puerto en Alpine
  4. Salir"

👉 Para la opción 1 (alpine login)

user: root

password: Secret123

```bash
$ poweroff 
```

⚠️ apagar qemu para no quedar atrapado en alpine login al cerrar sesión con "exit" ⚠️

## 🛠️ Acceso manual a Alpine Linux

```bash
$ cd alpine
$ ./startqemu.sh
```

👉 alpine login

user: root

password: Secret123

```bash
$ poweroff 
```

⚠️ apagar qemu para no quedar atrapado en alpine login al cerrar sesión con "exit" ⚠️


## 🛠️ Opcionalmente se puede cambiar la contraseña

⚠️ La contraseña de root es "Secret123", pero el root en ssh está bloqueado por contraseña.

👉 Cambia la contraseña de todos modos.

🚀 Tambien se puede acceder mediante SSH con una segunda terminal y "ssh2qemu.sh" qemukey / qemukey.ssh son claves SSH


## 🛠️ Configurar acceso directo con la aplicación Termux widgets:

👉 Descargar e Instalar la última versión de Termux/Widgets desde F-droid 

⚠️ Ver instalación y configuración: https://github.com/termux/termux-widget

👉 Copiar archivo "qemu-alpine.sh" en la carpeta de widgets

```bash
$ cd alpine
$ cp qemu-alpine.sh ../.shortcuts/
```

## 🚀🚀 Ejecutar "uname -a" o un "docker run hello-world" 🚀🚀

## Problemas conocidos

- kubernetes: cgroups en Alpine deben configurarse correctamente
- mas información en: <https://wiki.alpinelinux.org/wiki/Docker>

## ❤️ Agradecimientos ❤️

- Gracias a todos los que hicieron posible esto. Especialmente a AntonyZ89 y LinuxDroidMaster por la inspiración.


# ////////////////// Contenido Adicional //////////////////

👉 Cómo reenviar un puerto de Termux nativo a Alpine para poder acceder a las aplicaciones:

👉 Desde la carpeta alpine:

```bash
$ ssh -i qemukey -L 8080:localhost:4647 root@localhost -p 2222
```

Esto reenviará el puerto 8080 en Termux nativo al puerto 4647 en el contenedor Alpine.

# 🐋 Cómo ejecutar contenedores con Docker

👉 Iniciar sesión en Alpine con los puertos ssh 8080 en Termux y 4647 en el contenedor alpine

👉 Crear una carpeta:

```bash
$ mkdir nginx
$ cd nginx
```

👉 Crear un archivo index.html y copiar el siguiente contenido:

```bash
$ vim index.html
```

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prueba de Nginx</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        h1 {
            color: #333;
        }
    </style>
</head>
<body>
    <h1>Hola desde Docker!</h1>
    <p>Hello from Docker!</p>
</body>
</html>
```

👉 Crear un archivo Dockerfile con el siguiente contenido:

```bash
$ vim Dockerfile
```

```bash
FROM nginx:alpine

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx.conf /etc/nginx/conf.d/

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
Create a Nginx config file:
nano nginx.conf
server {
    listen 80;
    server_name localhost;

    location / {
        root /usr/share/nginx/html;
        index index.html;
    }
}
```

👉 Hacer build y ejecutar contenedor docker:

```bash
$ docker build -t my-nginx-container .
$ docker run -d -p 4647:80 --name nginx-container my-nginx-container
```

👉 Otros comandos útiles:

• Comprobar contenedores en ejecución:

```bash
$ docker ps
```

• Verificar todos los contenedores del sistema.:

```bash
$ docker ps -a
```

• Iniciar y detener un contenedor:

```bash
$ docker start my-nginx-container
$ docker stop my-nginx-container
```


# //////////////////// Original Script ////////////////////

## docker-qemu-alpine

Run Docker x86_64 on Android with Termux

Original idea: <https://gist.github.com/oofnikj/e79aef095cd08756f7f26ed244355d62> and <https://github.com/egandro/docker-qemu-arm>

Reviews and Updates: 

<https://github.com/AntonyZ89/docker-qemu-arm> and <https://github.com/LinuxDroidMaster/Termux-Projects/blob/main/projects/docker_android.md>
