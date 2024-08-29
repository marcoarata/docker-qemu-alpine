#!/bin/bash

## Este script por ahora solo funciona para Termux.
## Funciona con Termux Widgets. Mover archivo a: ~/data/data/com.termux/files/home/.shortcuts
## Para usar este Script:
## Modifica esta variable si se conserva la instalación: DIR="docker-qemu-alpine/alpine"

# Variables
DIR="alpine"
KEY_FILE="qemukey"
USER="root"
HOST="localhost"
PORT="2222"

# Cambia al directorio adecuado
cd && cd "$DIR" || { echo "Directorio no encontrado: $DIR"; exit 1; }

# Función para mostrar el menú
mostrar_menu() {
  echo "Selecciona una opción:"
  echo "1. Iniciar Alpine Linux con Contraseña"
  echo "2. Conéctate a tu sesión de Alpine Linux usando SSH"
  echo "3. Redirigir un puerto desde Termux hacia un puerto en Alpine"
  echo "4. Salir"
}

# Función para iniciar Alpine Linux
iniciar_alpine() {
  echo "Iniciando Alpine Linux..."
  ./startqemu.sh
}

# Función para mostrar advertencia al usar SSH o redirigir puertos
advertencia() {
  echo "ADVERTENCIA: Asegúrate de que Alpine Linux esté iniciado y de haber iniciado sesión con contraseña antes de continuar."
  read -p "¿Deseas continuar? (s/n): " respuesta
  if [[ "$respuesta" != "s" ]]; then
    echo "Operación cancelada."
    exit 0
  fi
}

# Función para conectarse a Alpine Linux usando SSH
conectar_ssh() {
  advertencia
  echo "Conectándose a Alpine Linux usando SSH..."
  ssh -i "$KEY_FILE" "$USER@$HOST" -p "$PORT"
}

# Función para redirigir un puerto
redirigir_puerto() {
  advertencia
  read -p "Ingresa el puerto inicial nativo de Termux: " puerto_origen
  read -p "Ingresa el puerto de destino en la VM de Alpine: " puerto_destino
  echo "Redirigiendo el puerto $puerto_origen en Termux al puerto $puerto_destino en Alpine..."
  ssh -i "$KEY_FILE" -L "$puerto_origen:localhost:$puerto_destino" "$USER@$HOST" -p "$PORT"
}

# Bucle principal
while true; do
  mostrar_menu
  read -p "Ingresa una opción y luego presiona enter: " opcion
  case $opcion in
    1)
      iniciar_alpine
      ;;
    2)
      conectar_ssh
      ;;
    3)
      redirigir_puerto
      ;;
    4)
      echo "Saliendo..."
      exit 0
      ;;
    *)
      echo "Opción no válida, por favor intenta de nuevo."
      ;;
  esac
done
