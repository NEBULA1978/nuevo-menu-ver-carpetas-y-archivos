# nuevo-menu-ver-carpetas-y-archivos


Este script en bash es un pequeño programa que permite explorar los archivos y carpetas en el sistema y en la carpeta home del usuario en un sistema basado en Linux (en este caso, Linux Mint).

El script comienza preguntando al usuario si desea ver el contenido de la carpeta home o del sistema. El usuario puede responder con "H" para la carpeta home o "S" para el sistema.

A continuación, se invoca la función show_content con el directorio seleccionado como argumento. Esta función muestra los archivos y carpetas en el directorio actual y permite al usuario elegir si desea entrar en una carpeta, leer un archivo con el comando cat, retroceder a la carpeta anterior o salir del programa.

La función show_content hace un bucle infinito hasta que el usuario selecciona "S" para salir. Cada vez que se ejecuta, muestra los archivos y carpetas en el directorio actual y pregunta al usuario si desea entrar en una carpeta, leer un archivo, retroceder a la carpeta anterior o salir.

Si el usuario elige entrar en una carpeta, se pide el nombre de la carpeta y se cambia al directorio especificado. Si la carpeta no existe, se muestra un mensaje de error.

Si el usuario elige leer un archivo, se pide el nombre del archivo y se muestra su contenido con el comando cat. Si el archivo no existe, se muestra un mensaje de error.

Si el usuario elige retroceder a la carpeta anterior, se cambia al directorio padre con el comando cd ...

Si el usuario elige salir, se sale del programa.

Este script es solo un ejemplo básico, pero puede ser útil para aprender a navegar por los archivos y carpetas en un sistema Linux, y puede ser modificado o expandido según sus necesidades.

Dar permisos chmod +x * .sh
./menubase4.sh

