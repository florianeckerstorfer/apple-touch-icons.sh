#!/usr/bin/env bash

bold=`tput bold`
norm=`tput sgr0`

original="./apple-touch-icon.png"

if [[ -d $original ]]; then
	echo "Could not find apple-touch-icon.png." >&2
	exit 1
fi

echo -n "Precomposed? [y/n] "
read precomposed

if [ $precomposed == "y" ]; then
	icon144="apple-touch-icon-144x144-precomposed.png"
	icon114="apple-touch-icon-114x114-precomposed.png"
	icon72="apple-touch-icon-72x72-precomposed.png"
	icon57="apple-touch-icon-57x57-precomposed.png"
else
	icon144="apple-touch-icon-144x144.png"
	icon114="apple-touch-icon-114x114.png"
	icon72="apple-touch-icon-72x72.png"
	icon57="apple-touch-icon-57x57.png"
fi
cp apple-touch-icon.png apple-touch-icon-precomposed.png
convert -resize 144x144 apple-touch-icon.png $icon144
convert -resize 114x114 apple-touch-icon.png $icon114
convert -resize 72x72 apple-touch-icon.png $icon72
convert -resize 57x57 apple-touch-icon.png $icon57
