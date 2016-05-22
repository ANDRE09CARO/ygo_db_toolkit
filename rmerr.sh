#!/bin/bash
echo "> Checking for bad files"

# locale choice
echo "> Using last locale"
loc=$(cat ./loc)

# main script
let "f = 8345"

for i in {4007..12352}
do
	let "y = i-4006"
	case $loc in
	ja ) err=$(grep -ic "カード情報がありません" ./html/$i.html);;
	en ) err=$(grep -ic "No Data Found" ./html/$i.html);;
	fr ) err=$(grep -ic "Aucune donnée trouvée" ./html/$i.html);;
	it ) err=$(grep -ic "Dati non trovati" ./html/$i.html);;
	de ) err=$(grep -ic "Keine Daten gefunden" ./html/$i.html);;
	es ) err=$(grep -ic "No hay datos" ./html/$i.html);;
	esac
	
	if [ $err -ge 1 ] 
	then
	  mv ./html/$i.html ./empty/$i.html
	  echo "$i" >> ./empty_ids
	fi
	
	let "p = $y*30 / $f"
	let "n = 30 - $p"
	bar=$(head -c $p < /dev/zero | tr '\0' '=')
	air=$(head -c $n < /dev/zero | tr '\0' ' ')
	echo -ne "> [$bar $air] ($y/$f) \r"
done
echo -ne '\n'
