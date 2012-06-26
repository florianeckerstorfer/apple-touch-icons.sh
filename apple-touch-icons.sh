#!/usr/bin/env bash

# Script for automatically creating 
# apple-touch-icons and the favicon file
# using ImageMagick
#
# Usage:
# ======
#
# Use the file apple-touch-icon.png as master
# for the derived icons:
#
#	./apple-touch-icons.sh
#
# Pass a specific file to be used as master:
#
#	./apple-touch-icons.sh /home/john/icon.svg
#

bold=`tput bold`
norm=`tput sgr0`

base_touch_icon="./apple-touch-icon.png"

# If a parameter is given, use it as master-file.
# All occurences of $@ or $original are embraced
# by apostrophes to support file names with spaces.
if [ "$@" ]; then
	original="$@"
else
	original=$base_touch_icon
fi

# Does the original touch-icon exist?
if [ ! -f "$original" ]; then
	echo "Could not find $original." >&2
	exit 1
fi

echo -n "Precomposed? (If precomposed, Apple-devices will not add rounded corners and gloss-effect) [y/n] "
read precomposed

if [ $precomposed == "y" ]; then
	appendix="-precomposed"
fi

for size in 144 114 72 57
do
	/usr/bin/convert			\
		-resize $size"x"$size		\
		"$original"			\
		apple-touch-icon-$size"x"$size$appendix.png
done

# Copy the 57x57 sized icon to use as base,
# if not already there:
if [ "$original" != "$base_icon" ]; then
	/bin/cp apple-touch-icon-57x57$appendix.png $base_touch_icon
fi

echo -n "Generate favicon? [y/n] "
read favicon

if [ $favicon == "y" ]; then
	/usr/bin/convert -resize 16x16 "$original" favicon.ico
fi
