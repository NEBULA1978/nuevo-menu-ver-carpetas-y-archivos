import os


def show_content(current_dir):
    while True:
        os.system('clear')  # Limpia la terminal
        print(f"Directorio actual: {current_dir}")
        print("Contenido:")
        contents = os.listdir(current_dir)
        for content in contents:
            print(content)

        option = input(
            "¿Qué quieres hacer? (C = Entrar en carpeta, L = Leer archivo, R = Retroceder, S = Salir): ")

        if option.lower() == 'c':
            folder = input("Escribe el nombre de la carpeta: ")
            folder_path = os.path.join(current_dir, folder)
            if os.path.isdir(folder_path):
                current_dir = folder_path
            else:
                print(f"La carpeta {folder} no existe.")

        elif option.lower() == 'l':
            file = input("Escribe el nombre del archivo: ")
            file_path = os.path.join(current_dir, file)
            if os.path.isfile(file_path):
                with open(file_path, 'r') as f:
                    file_contents = f.read()
                    print(file_contents)
                    copy = input(
                        "¿Quieres copiar desde la linea 1 a la 10 y guardar en archivo-copia-lineas.txt? (S/N)")
                    if copy.lower() == 's':
                        lines = file_contents.split('\n')[:10]
                        with open("archivo-copia-lineas.txt", 'w') as f2:
                            f2.write('\n'.join(lines))
                            print("Archivo guardado.")
                input("Presiona enter para continuar.")
            else:
                print(f"El archivo {file} no existe.")

        elif option.lower() == 'r':
            if current_dir != '/':
                current_dir = os.path.abspath(
                    os.path.join(current_dir, os.pardir))
            else:
                print("Ya estás en la raíz del sistema.")

        elif option.lower() == 's':
            break
        else:
            print("Opción inválida.")


choice = input("¿Quieres entrar en una carpeta de home o del sistema? (H/S) ")

if choice.lower() == 'h':
    current_dir = os.path.expanduser("~")
elif choice.lower() == 's':
    current_dir = '/'
else:
    print("Opción inválida.")
    exit(1)

show_content(current_dir)
