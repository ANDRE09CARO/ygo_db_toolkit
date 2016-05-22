#!/bin/bash
echo "> Saving database pages"

# locale choice
read -p "> Please select the desired database locale (ja,en,fr,it,de,es) : " loc
case $loc in
	ja|en|fr|it|de|es ) echo $loc > ./loc;;
	* ) echo "> Wrong locale, using last one by default";
		loc=$(cat ./loc);;
esac

# number of exclusions
badids=$(wc -l ./empty_ids_pregen | head --bytes=-20)

# main script
y=1
let "f = 8345-$badids"
	
for i in {4007..12352}
do
	err=$(grep -ic "$i" ./empty_ids_pregen)
	if [ $err -eq 0 ]
	then
		wget -q "http://www.db.yugioh-card.com/yugiohdb/card_search.action?ope=2&cid=$i&request_locale=$loc" -O  ./html/$i.html
		
		let "p = $y*30 / $f"
		let "n = 30 - $p"
		bar=$(head -c $p < /dev/zero | tr '\0' '=')
		air=$(head -c $n < /dev/zero | tr '\0' ' ')
		echo -ne "> [$bar $air] ($y/$f) \r"
		let "++y"
	else
		echo "$i" >> ./empty_ids
	fi
done
echo -ne '\n'
