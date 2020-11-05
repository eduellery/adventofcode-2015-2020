#!/usr/bin/env sh

for file in *; do
	if [[ $file == *.py ]]; then
		day=${file:1:2};
		echo Day $day;
		python d$day.py;
		echo
	fi
done
