#!/bin/bash
#Standard input
tekst=$(</dev/stdin)
#Feilmelding hvis argument blir med
[[ ! -z $1 ]] && [[ "$1" != "--bypass" || $# -gt 1 ]] && echo "Error:Illegal argument '$1'" >&2 && exit 1
#Lager temp dir
tmp_dir=$(mktemp -d -t ci-XXXX)
	#Lagrer tekst til kryptert med å bruke depunctuate scriptet
	kryptertTekst=$(echo "$tekst" | bash depunctuate.sh "$tmp_dir")

	#Prøver words-resvere-11
	#Bypass med cat
	cat echo "$kryptertTekst" | bash words-reverse-11.sh


	#Lagrer kryptertTekst til dekryptertTekst med å bruke repunctuate scriptet
	dekryptertTekst=$(echo "$kryptertTekst" | bash repunctuate.sh "$tmp_dir")

	#Skriver dekryptertTekst
	echo "$dekryptertTekst"


#Sletter tmp dir
rm -rf $tmp_dir
