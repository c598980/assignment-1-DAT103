#!/bin/bash
#Tar inn standarinput
tekst=$(</dev/stdin)
#Sjekker standardinput
[[ $# == 0 ]]&& echo "Bruker: $0 <hashDirectory>">&2 && exit 1 
#Samler teksten
dekryptertTekst=""

while read; do
	#Lagrer hver linje i en variabel
	var="$REPLY"
		#Sjekker om filen finnes i $1
		if [[ -f "$1/$var" ]];
		then
		#Henter ut dekryperte string
			dekryptertTekst+=$(cat "$1"/"$var")
		else
			dekryptertTekst+=$(echo "$var")
		fi

done <<< "$tekst"

#Skriver ut den dekrypterte teksten
echo "$dekryptertTekst"
