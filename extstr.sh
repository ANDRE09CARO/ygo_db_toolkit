#!/bin/bash
echo "> Filtering data"

# number of exclusions
badids=$(wc -l ./empty_ids| head --bytes=-13)

# main script
y=1
let "f = 8345-$badids"

for i in {4007..12352}
do
	err=$(grep -ic "$i" ./empty_ids)
	if [ $err -eq 0 ]
	then
		echo $(grep -Poz '<header id="broad_title">\s*<div>\s*<h1>\s*\K.*\n' ./html/$i.html) > ./txt/$i
		echo $(grep -Poz '<span class="item_box_title">\s*<b>.*</b>\s*</span>\s*(<span class="item_box_value">\s*)?\K.*\n' ./html/$i.html) >> ./txt/$i
		echo $(grep -Poz '<div class="item_box_title">\s*<b>.*</b>\s*</div>\s*\K.*\n' ./html/$i.html) >> ./txt/$i
		
		let "p = $y*30 / $f"
		let "n = 30 - $p"
		bar=$(head -c $p < /dev/zero | tr '\0' '=')
		air=$(head -c $n < /dev/zero | tr '\0' ' ')
		echo -ne "> [$bar $air] ($y/$f) \r"
		let "++y"
	fi
done
echo -ne '\n'

# included in boosters
# grep -Po '<td>\K[A-Z]{4}-[A-Z]{2}[0-9]{3}' ./html/4007.html
