#!/bin/bash

#!/bin/bash

# Función que muestra las carpetas y archivos dentro de una carpeta
show_content () {
  local current_dir=$1

  # Muestra las carpetas y archivos dentro de la carpeta actual
  echo "Carpetas y archivos en $current_dir:"
  for item in $current_dir/*; do
    if [ -d "$item" ]; then
      echo "Carpeta: $(basename "$item")"
    elif [ -f "$item" ]; then
      echo "Archivo: $(basename "$item")"
    fi
  done

  # Pregunta al usuario si desea entrar en una carpeta o leer un archivo
  read -p "¿Quieres entrar en una carpeta o leer un archivo? (C/A) " choice
  choice=$(echo $choice | tr '[:lower:]' '[:upper:]')
  if [ "$choice" == "C" ]; then
    read -p "Introduce el nombre de la carpeta: " folder
    if [ -d "$current_dir/$folder" ]; then
      show_content "$current_dir/$folder"
    else
      echo "La carpeta $folder no existe en $current_dir."
    fi
  elif [ "$choice" == "A" ]; then
    read -p "Introduce el nombre del archivo: " file
    if [ -f "$current_dir/$file" ]; then
      while true; do
        cat "$current_dir/$file"
        read -p "¿Quieres leer otro archivo o entrar en una carpeta? (A/C) " next_choice
        next_choice=$(echo $next_choice | tr '[:lower:]' '[:upper:]')
        if [ "$next_choice" == "A" ]; then
          read -p "Introduce el nombre del archivo: " file
          if [ ! -f "$current_dir/$file" ]; then
            echo "El archivo $file no existe en $current_dir."
            break
          fi
        elif [ "$next_choice" == "C" ]; then
          break
        else
          echo "Opción inválida."
        fi
      done
    else
      echo "El archivo $file no existe en $current_dir."
    fi
  else
    echo "Opción inválida."
  fi
}

# Inicia el script mostrando el contenido de la carpeta home y del sistema
echo "Carpetas en home:"
for item in ~/; do
  echo "$(basename "$item")"
done

echo "Carpetas en el sistema:"
for item in /; do
  echo "$(basename "$item")"
done

read -p "¿Quieres entrar en una carpeta de home o del sistema? (H/S) " choice
choice=$(echo $choice | tr '[:lower:]' '[:upper:]')
if [ "$choice" == "H" ]; then
  show_content ~/
elif [ "$choice" == "S" ]; then
  show_content /
else
  echo "Opción inválida."
fi







