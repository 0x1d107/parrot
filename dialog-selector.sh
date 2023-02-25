#!/bin/bash

HASH=()
MENUARGS=()
i=0
while read -r LINE;
do 
	name="${LINE%[|]*}"
	HASH[$i]="${LINE##*[|]}"
	MENUARGS+=( "$i" "$name" )
	i=$(( $i + 1 ))
done

ans=$(dialog --menu 'Select the file to download' 0 0 0 "${MENUARGS[@]}" 3>&1 1>&2 2>&3 3>&-)
[ -z "$ans" ] || echo "${HASH[$ans]}"
