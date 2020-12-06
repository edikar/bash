#!/bin/bash

wget -q https://www.ynetnews.com/category/3082 -O temp_news.txt

grep -o "https://www.ynetnews.com/article/[a-zA-Z0-9]\{9\}" temp_news.txt > temp_link_list.txt

sort temp_link_list.txt | uniq > temp_uniq_links.txt

cat temp_uniq_links.txt | wc -l > results.csv

for link in `cat temp_uniq_links.txt`; do
	wget -q $link -O tmp.txt

	gantz_count=`grep Gantz tmp.txt | wc -l`
	bibi_count=`grep Netanyahu tmp.txt | wc -l`

	echo -n "$link, " >> results.csv

	if (( gantz_count == 0 && bibi_count == 0 ))
	then
		echo "-" >> results.csv
	else
		echo -n "Netanyahu, $bibi_count, " >> results.csv
		echo "Gantz, $gantz_count" >> results.csv
	fi
done
