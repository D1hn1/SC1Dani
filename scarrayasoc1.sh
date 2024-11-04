#!/bin/bash

: '
Programa llamado scarrayasoc1.sh al que le paso un número indeterminado de nombre de colores (por ejemplo scarrayasoc1.sh rojo verde azul). El programa hará :

    Me dirá cuántos colores le he pasado
    Por cada color, me pedirá que le introduzcamos su representación en hexadecimal.
    Lo guardaremos en un array asociativo, donde la key será el color y el valor su representación hexadecimal.
    Me mostrará un listado de los colores que puedo seleccionar (los introducidos por el usuario).
    Y ahora me irá preguntando de qué color quiero los siguientes elementos de la página web que vamos a generar:
        Color de fondo de la página web
        Color del párrafo/div en el que voy a poner el texto
        Color del texto.
    Me generará una página web llamada índex_tunombre.html con dichas características, que me muestre la información de mi ip (por ejemplo, la que me muestra ifconfig).
    La página web resultante (.html) habrá que subirla junto al script que la ha generado, en esta tarea.
'

if [ $# -lt 1 ]; then
	echo "Ussage: $0 red blue ..."
	exit 0
fi

dprint () { echo $( date +%T )"	| $1"; };
dprint "Has pasado $# argumentos"


#  .- Crear el array con valores -.

declare -A color_array
echo

for color in $(cat colors); do
	colorv=$(cut -d " " -f 1)
	hex_value=$(cut -d " " -f 2)
	color_array[$colorv]=$hex_value
done

# .- Mostrar los colores -.

dprint "Colores:"
for color in $@; do
	dprint $color" -> "${color_array[$color]}
done

# .- Preguntar por colores -.

for x in $(seq 0, 2); do
	case $x in
		0)
			read -p "Introduce un color para el fondo: " bac_col
		;;
		1)
			read -p "Introduce un color para el div: " div_col
		;;
		2)
			read -p "Introduce un color para el texto: " tex_col 
		;;
		*)
			continue
		;;
	esac
done

# .- Generar página web -.

echo "<html><head><title>BASH</title></head><body><div id=id-1>$(ifconfig)</div></body><style>body{height:100%;background-color:${color_array[$bac_col]};display:flex;justify-content:center;align-items:center;}#id-1{width:fit-content;height:fit-content;background-color:${color_array[$div_col]};color:${color_array[$tex_col]};}</style></html>" > index_dani.html
dprint "Page created!"
