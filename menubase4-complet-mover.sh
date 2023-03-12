#!/bin/bash

# Muestra el contenido de una carpeta, preguntando al usuario si desea
# entrar en una carpeta, leer un archivo, mover un archivo, salir del script o retroceder a la
# carpeta anterior
function show_content() {
  read -p "¿Quieres ver la ruta absoluta de la carpeta actual? (S/N) " choice
  choice=$(echo $choice | tr '[:lower:]' '[:upper:]')
  if [ "$choice" == "S" ]; then
    current_dir=$(cd "$current_dir"; pwd)
  else
    current_dir=$1
  fi


  # Muestra el contenido de la carpeta actual
  echo "El contenido de la carpeta $current_dir es:"
  ls -1 $current_dir

  # Pregunta al usuario si desea entrar en una carpeta, leer un archivo, mover un archivo, salir
  # del script o retroceder a la carpeta anterior
  read -p "¿Quieres entrar en una carpeta, leer un archivo, mover un archivo, salir o retroceder? (C/L/M/S/R) " choice
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
        read -p "¿Quieres leer otro archivo, entrar en una carpeta, mover un archivo, salir o retroceder? (L/C/M/S/R) " next_choice
        next_choice=$(echo $next_choice | tr '[:lower:]' '[:upper:]')
        if [ "$next_choice" == "L" ]; then
          read -p "Introduce el nombre del archivo: " file
          if [ -f "$current_dir/$file" ]; then
            cat "$current_dir/$file"
          else
            echo "El archivo $file no existe en $current_dir."
          fi
        elif [ "$next_choice" == "C" ]; then
          read -p "Introduce el nombre de la carpeta: " folder
          if [ -d "$current_dir/$folder" ]; then
            cd "$current_dir/$folder"
            show_content "$current_dir/$folder"
          else
            echo "La carpeta $folder no existe en $current_dir."
          fi
        elif [ "$next_choice" == "M" ]; then

          read -p "Introduce el nombre del archivo a mover: " file
          echo "El contenido de la carpeta $current_dir es:"
          ls -1 "$current_dir"
          
          options=("Desktop" "Documents" "Downloads" "Music" "Pictures" "Videos")
          select folder in "${options[@]}"; do
            if [ -d "$current_dir/$folder" ]; then
              folder="$current_dir/$folder"
              break
            else
              echo "Opción inválida, elige una de las siguientes opciones:"
            fi
          done

          read -p "Introduce el nombre de la carpeta destino: " folder

          if [ -f "$current_dir/$file" ] && [ -d "$current_dir/$folder" ]; then
mv "$current_dir/$file" "$current_dir/$folder/$file"
echo "El archivo $file ha sido movido a la carpeta $folder."
elif [ ! -f "$current_dir/$file" ]; then
echo "El archivo $file no existe en $current_dir."
elif [ ! -d "$current_dir/$folder" ]; then
echo "La carpeta $folder no existe en $current_dir."
fi
elif [ "$next_choice" == "S" ]; then
exit
elif [ "$next_choice" == "R" ]; then
cd ..
show_content "$(dirname "$current_dir")"
else
echo "Opción inválida, elige una de las siguientes: (L/C/M/S/R)."
fi
done
else
echo "El archivo $file no existe en $current_dir."
fi
elif [ "$choice" == "M" ]; then
read -p "Introduce el nombre del archivo a mover: " file
read -p "Introduce el nombre de la carpeta destino: " folder
if [ -f "$current_dir/$file" ] && [ -d "$current_dir/$folder" ]; then
mv "$current_dir/$file" "$current_dir/$folder/$file"
echo "El archivo $file ha sido movido a la carpeta $folder."
elif [ ! -f "$current_dir/$file" ]; then
echo "El archivo $file no existe en $current_dir."
elif [ ! -d "$current_dir/$folder" ]; then
echo "La carpeta $folder no existe en $current_dir."
fi
elif [ "$choice" == "S" ]; then
exit
elif [ "$choice" == "R" ]; then
cd ..
show_content "$(dirname "$current_dir")"
else
echo "Opción inválida, elige una de las siguientes: (C/L/M/S/R)."
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


# RESULTADO POR CONSOLA

# ./menubase4-complet-mover.sh
# ¿Quieres ver el contenido de la carpeta home o del sistema? (H/S) h
# ¿Quieres ver la ruta absoluta de la carpeta actual? (S/N) s
# El contenido de la carpeta /home/next/Música/ver-varpetas-bash/nuevo-menu-ver-carpetas-y-archivos es:
# archivo-copia-lineas.txt
# menubase2.sh
# menubase3.sh
# menubase4-complet-mover.sh
# menubase4-completo.sh
# menubase4-completo-while-case-copiar-lineas-archivo2-pyhon3.py
# menubase4-completo-while-case-copiar-lineas-archivo2.sh
# menubase4-completo-while-case-copiar-lineas-archivo.sh
# menubase4-completo-while-case.sh
# menubase.sh
# prueba-move-archivos
# README.md
# ¿Quieres entrar en una carpeta, leer un archivo, mover un archivo, salir o retroceder? (C/L/M/S/R) m
# Introduce el nombre del archivo a mover: menubase.sh
# Introduce el nombre de la carpeta destino: /home/next/Música/ver-varpetas-bash/nuevo-menu-ver-carpetas-y-archivos
# La carpeta /home/next/Música/ver-varpetas-bash/nuevo-menu-ver-carpetas-y-archivos no existe en /home/next/Música/ver-varpetas-bash/nuevo-menu-ver-carpetas-y-archivos.