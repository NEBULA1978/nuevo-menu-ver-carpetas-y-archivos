#!/bin/bash

# Muestra el contenido de una carpeta, preguntando al usuario si desea
# entrar en una carpeta, leer un archivo, salir del script o retroceder a la
# carpeta anterior
function show_content() {
  current_dir=$1

  # Muestra el contenido de la carpeta actual
  echo "El contenido de la carpeta $current_dir es:"
  ls -1 $current_dir

  # Pregunta al usuario si desea entrar en una carpeta, leer un archivo, salir
  # del script o retroceder a la carpeta anterior
  read -p "¿Quieres entrar en una carpeta, leer un archivo, salir o retroceder? (C/L/S/R) " choice
  choice=$(echo $choice | tr '[:lower:]' '[:upper:]')
  if [ "$choice" == "C" ]; then
    read -p "Introduce el nombre de la carpeta: " folder
    if [ -d "$current_dir/$folder" ]; then
      cd "$current_dir/$folder"
      show_content "$current_dir/$folder"
    else
      echo "La carpeta $folder no existe en $current_dir."
    fi
  elif [ "$choice" == "L" ]; then
    read -p "Introduce el nombre del archivo: " file
    if [ -f "$current_dir/$file" ]; then
      cat "$current_dir/$file"
      while true; do
        read -p "¿Quieres leer otro archivo, entrar en una carpeta, salir o retroceder? (L/C/S/R) " next_choice
        next_choice=$(echo $next_choice | tr '[:lower:]' '[:upper:]')
        if [ "$next_choice" == "L" ]; then
          read -p "Introduce el nombre del archivo: " file
          if [ -f "$current_dir/$file" ]; then
            cat "$current_dir/$file"
          else
            echo "El archivo $file no existe en $current            dir."
          fi
        elif [ "$next_choice" == "C" ]; then
          read -p "Introduce el nombre de la carpeta: " folder
          if [ -d "$current_dir/$folder" ]; then
            cd "$current_dir/$folder"
            show_content "$current_dir/$folder"
          else
            echo "La carpeta $folder no existe en $current_dir."
          fi
        elif [ "$next_choice" == "S" ]; then
          exit
        elif [ "$next_choice" == "R" ]; then
          cd ..
          show_content "$(dirname "$current_dir")"
        else
          echo "Opción inválida, elige una de las siguientes: (L/C/S/R)."
        fi
      done
    else
      echo "El archivo $file no existe en $current_dir."
    fi
  elif [ "$choice" == "S" ]; then
    exit
  elif [ "$choice" == "R" ]; then
    cd ..
    show_content "$(dirname "$current_dir")"
  else
    echo "Opción inválida, elige una de las siguientes: (C/L/S/R)."
  fi
}

# Pregunta al usuario si desea ver el contenido de la carpeta home o del sistema
read -p "¿Quieres ver el contenido de la carpeta home o del sistema? (H/S) " choice
choice=$(echo $choice | tr '[:lower:]' '[:upper:]')
if [ "$choice" == "H" ]; then
  show_content "$HOME"
elif [ "$choice" == "S" ]; then
  show_content "/"
else
  echo "Opción inválida, elige una de las siguientes: (H/S)."
fi
