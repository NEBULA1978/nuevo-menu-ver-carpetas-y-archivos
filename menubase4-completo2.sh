#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function controlC() {
  # Parametro -e para que me aplique los saltos de linea
  echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n"
  showResults
  # Codigo de estado no exitoso
  exit 1
}

# controlC
# Para capturr el atajo de teclado que acabo de escribir y redirijirlo a la funcion controlC
trap controlC INT

# Si no ccomento se ejecuta despues de 10 segundos
# sleep 10


function showResults() {
  result=$(("$wins-$losses"))
  
  echo -e "\n${yellowColour}[+] Resumen del juego:${endColour}"
  echo -e "${greenColour}Jugadas ganadas:${endColour} $wins"
  # echo -e "${greenColour}Números ganadores:${endColour}$winning_numbers"
  echo -e "${redColour}Jugadas perdidas:${endColour} $losses"
  # echo -e "${redColour}Números perdedores:${endColour}$losing_numbers\n"
  echo -e "\n${yellowColour}[+] Resumen del juego: Ganadas $wins - Perdidas $losses ${endColour} = " "$result"
}

#///////////////////////////////////////////
#///////////////////////////////////////////

function helpPanel() {
  # Hacemos mencion el nombre del script que estamos ejecutando con $0
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Uso:${endColour}${purpleColour} $0${endColour}\n"
  echo -e "\t${blueColour}-m)${endColour}${grayColour} Dinero con el que desea jugar${endColour}"
  echo -e "\t${blueColour}-t)${endColour} Tecnica de juego a utilizar${endColour}${purpleColour} (${endColour}${yellowColour}martingala${endColour}${blueColour}/${endColour}${yellowColour}inverseLabroucher${endColour}${purpleColour})${endColour}\n"
  exit 1
}
function martingala() {

  # Inicializar variables de conteo y números ganadores y perdedores
  wins=0
  losses=0
  winning_numbers=""
  losing_numbers=""

  echo -e ""
  echo -e "\033[1;34m[+] Dinero actual ${money}€\033[0m|"
  echo -e ""
  echo -ne "\033[1;34m[+] ¿Cuánto dinero quieres empezar a apostar?\033[0m\033[1;31m€ -> " && read initial_bet

  # Comprobamos si la cantidad de la apuesta es mayor que el dinero disponible
  if [ "$initial_bet" -gt "$money" ]; then
    echo -e "\n${redColour}[+] Lo siento, no tienes suficiente dinero para hacer esa apuesta.${endColour}\n"
    initial_bet=$money
  fi

  echo -ne "\n\033[1;34m[+] Vamos a empezar con una cantidad incicial de $initial_bet€\033[0m "
  echo -e "\n"

  # Creamos backup
  backup_bet=$initial_bet

  # Iniciamos While
  tput civis #Ocultar
  while true; do
    if [ "$money" -eq 0 ]; then
      echo -e "\n${redColour}[+] Lo siento, te has quedado sin dinero. El juego ha terminado.${endColour}\n"
      break
    fi
    echo -e "\n${yellowColour}[+]${endColour}${yellowColour} Acabas de apostar${endColour} ${blueColour}$initial_bet€${endColour} ${yellowColour}y tienes${endColour} ${blueColour}$money€${endColour}"

    # Generamos un número aleatorio para decidir si apostamos a par o impar
    random_number=$((RANDOM % 2))
    if [ $random_number -eq 0 ]; then
      par_impar="par"
    else
      par_impar="impar"
    fi
    echo -e "\n${yellowColour}[+] Vamos a apostar a $par_impar\033[0m "
    random_number="$(($RANDOM % 37))"
    echo -e "${yellowColour}[+] Ha salido el número${endColour} ${blueColour}$random_number${endColour}"
    # sleep 1

    if [ "$(($random_number % 2))" -eq 0 ]; then
      # Si el número que ha salido es igual a 0, has perdido
      if [ "$random_number" -eq 0 ]; then
        echo -e "\n${yellowColour}[+] Ha salido el 0, por tanto pierdes${endColour}\n"
        money=$(($money - $initial_bet))
        initial_bet=$(($initial_bet / 2)) # Ajuste de apuesta después de perder por cero
        if [ "$initial_bet" -lt "$backup_bet" ]; then
          initial_bet=$backup_bet
          losses=$((losses + 1))
          losing_numbers="$losing_numbers $random_number"
        fi
      else
        echo -e "\n${yellowColour}[+] El número que ha salido es Par, ${endColour} ${purpleColour} Ganas${endColour}\n"
        reward=$(($initial_bet * 2))
        echo -e "\n${yellowColour}[+] Ganas un total de${endColour} ${blueColour}$reward€${endColour}"
        money=$(($money + $reward))
        echo -e "\n${yellowColour}[+] Tienes${endColour} ${blueColour}$money€${endColour}\n"
        initial_bet=$backup_bet
        wins=$((wins + 1))
        winning_numbers="$winning_numbers $random_number"
      fi
    else
      echo -e "\n${yellowColour}[+] El número que ha salido es Impar ${endColour} ${redColour}Pierdes ${endColour}\n"
      money=$(($money - $initial_bet))
      initial_bet=$(($initial_bet * 2))
      losses=$((losses + 1))
      losing_numbers="$losing_numbers $random_number"
      echo -e "\n${yellowColour}[+] Ahora te quedan ${endColour} ${redColour}$money€ ${endColour}\n"
      # sleep 1
      # Si se queda sin dinero se acaba el juego
      if [ "$money" -eq 0 ]; then
        echo -e "\n${yellowColour}[+] Te has quedado sin dinero, fin del juego.${endColour}\n"
        echo -e "\n${yellowColour}[+] Resumen del juego:${endColour}"
        echo -e "${greenColour}Jugadas ganadas:${endColour} $wins"
        echo -e "${greenColour}Números ganadores:${endColour}$winning_numbers"
        echo -e "${redColour}Jugadas perdidas:${endColour} $losses"
        echo -e "${redColour}Números perdedores:${endColour}$losing_numbers"

        exit 1
      fi
    fi

    # Comprobamos si la cantidad de la apuesta es mayor que el dinero disponible después de cada jugada
    if [ "$initial_bet" -gt "$money" ]; then
      echo -e "\n${redColour}[+] Lo siento, no tienes suficiente dinero para hacer esa apuesta.${endColour}\n"
      initial_bet=$money
    fi
  done

  tput cnorm #Recuperamos el cursor
}

# VOY MINUTO 13 video: Scripting en Bash [4-15]

while getopts "m:t:h" arg; do
  case $arg in
  m) money=$OPTARG ;;
  t) technique=$OPTARG ;;
  # Cuando falle la opcion vamos a la  funcion panel de ayuda
  h) helpPanel ;;

  esac
done

# Estas dos variables tienen que tener contenido
if [ $money ] && [ $technique ]; then
  # echo -e  "\n${yellowColour}Voy a jugar con $money€ dinero usando la tecnica $technique\n${endColour}"
  if [ "$technique" == "martingala" ]; then
    martingala
  else
    echo -e "\n${yellowColour}La técnica de juego introducida ($technique) no es valida\n${endColour}"
    helpPanel
  fi
else
  helpPanel
fi

# El código que proporcionaste es un script de shell en Bash. En resumen, este script simula un juego de azar en el que el usuario apuesta una cantidad de dinero y apuesta a que un número aleatorio será par o impar. El script incluye dos técnicas de juego: "martingala" e "inverseLabroucher". El usuario debe especificar la cantidad de dinero con la que desea jugar y la técnica que desea utilizar al ejecutar el script con los argumentos adecuados.

# El script también incluye una función de ayuda que se activa si se pasa el argumento "-h". La función de ayuda proporciona información sobre cómo utilizar el script y las opciones disponibles.

# El script utiliza colores para mejorar la legibilidad de la salida y también maneja errores en caso de que el usuario no tenga suficiente dinero para realizar una apuesta o se quede sin dinero en medio del juego. En general, es un script interesante que muestra cómo se puede implementar un juego de azar en un entorno de shell en Bash.