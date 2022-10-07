#!/bin/bash
#Henter teksten vi skal jobbe med
tekst=$(</dev/stdin)
#Sjekker om argumentet finnes
[[ $# == 0 ]]&& echo "Bruker: $0 <hashDirectory>">&2 && exit 1
#Splitter opp teksten og legger den i en variabel
splittet="$(sed 's/\W\+/\n&\n/g' <<< $tekst)"


#Går gjennom splittet
while read; do
	#Henter inn hver linje og lagrer det i var
	var="$REPLY"

	#Sjekker hver linje om den ikke inneholder vanlige bokstaver
	if [[ "$var" =~ [^a-zA-Z0-9] ]];
	then
		#Krypterer chartegnet
		kryptert=$(echo -n "$var"| sha256sum | cut -c-64)

 		#Sjekker om krypterte filen finnes fra før
		if [[ -e "$1/$kryptert" ]];
		then

			#Henter ut innhold i filen
			sjekk=$(cat "$1/$kryptert")

			#Sjekker om det ikke er riktig innhold
			if [[ ! "$var" = "$sjekk" ]];
			then
			#Feilmelding og filen overkjøres
				echo "Filen inneholder feil"
				 exit 1
			fi

		else
			#Lager kryptert fil hvis filen ikke finnes
			echo "$var" > "$1/$kryptert"
		fi

			#Printer ut uansett om den finnes fra før eller ikke
			echo "$kryptert"

	else
	#Printer ut vanlig bokstav
	echo "$var"
	fi
done <<< "$splittet"






