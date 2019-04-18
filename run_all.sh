#!/usr/bin/env sh

for year in *; do
    if [[ -d $year ]]; then
	echo YEAR $year;
	echo;
	cd $year;
	for lang in *; do
		if [[ -d $lang ]]; then
			echo Language: $lang
			echo;
			cd $lang;
			time ./run_${year}_${lang}.sh
			cd ..;
		fi
		echo;
	done
	cd ..;
    fi
done
