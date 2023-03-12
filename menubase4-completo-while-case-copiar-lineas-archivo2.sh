#!/bin/bash

# Esta función muestra el contenido de un directorio, permite entrar en una subcarpeta,
# leer un archivo y copiar un rango de líneas a un nuevo archivo, y retroceder al directorio
# padre.
function show_content {
  local dir=$1 # Directorio actual
  local option # Opción elegida por el usuario

  echo "Ruta actual: $dir"
  while true; do
    clear
    echo "Directorio actual: $dir"
    echo "Contenido:"
    ls $dir
    read -p "¿Qué quieres hacer? (C = Entrar en carpeta, L = Leer archivo, R = Retroceder, S = Salir): " option
    case $option in
      [Cc]) # Entrar en una subcarpeta
            read -p "Escribe el nombre de la carpeta: " folder
            if [ -d "$dir/$folder" ]; then
              dir="$dir/$folder" # Cambiar al directorio elegido
            else
              echo "La carpeta $folder no existe."
            fi;;
      [Ll]) # Leer un archivo y copiar un rango de líneas a un nuevo archivo
            read -p "Escribe el nombre del archivo: " file
            if [ -f "$dir/$file" ]; then
              read -p "¿De qué línea a qué línea quieres copiar? (Ejemplo: 1 10): " start end
              sed -n "${start},${end}p" "$dir/$file" > "archivo-copia-lineas.txt"
              echo "Archivo copiado con éxito."
              read -p "Presiona enter para continuar."
            else
              echo "El archivo $file no existe."
            fi;;
      [Rr]) # Retroceder al directorio padre
            if [ "$dir" != "/" ]; then
              dir=$(dirname "$dir")
            else
              echo "Ya estás en la raíz del sistema."
            fi;;
      [Ss]) # Salir de la función
            break;;
      *) echo "Opción inválida.";;
    esac
  done
}

# Preguntar al usuario si quiere entrar en una carpeta de home o del sistema
read -p "¿Quieres entrar en una carpeta de home o del sistema? (H/S) " choice
choice=$(echo $choice | tr '[:lower:]' '[:upper:]')

# Establecer el directorio inicial
if [ "$choice" == "H" ]; then
  dir=~
elif [ "$choice" == "S" ]; then
  dir="/"
else
  echo "Opción inválida."
  exit 1
fi

# Llamar a la función show_content con el directorio inicial
show_content $dir
