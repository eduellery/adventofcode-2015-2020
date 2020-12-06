#!/usr/bin/env sh

for file in *; do
	if [[ $file == *.jl ]]; then
		day=${file:1:2};
		echo Day $day;
		julia d$day.jl;
		echo
	fi
done
