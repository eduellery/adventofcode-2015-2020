#!/usr/bin/env sh

for f in *; do
	if [[ -d $f ]]; then
		d=${f:1}
		echo Day $d
		javac -Xlint:unchecked $f/Day$d.java && java $f/Day$d
		echo
    fi
done
