#!/usr/bin/env sh

for file in *; do
	if [[ $file == *.java ]]; then
		day=${file:3:2};
		echo Day $day;
		javac -Xlint:unchecked Day$day.java && java Day$day
		echo
	fi
done

