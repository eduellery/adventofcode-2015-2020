#!/usr/bin/env sh

for f in *; do
    if [[ -d $f ]]; then
	echo Day $f;
	cd $f;
	python day$f.py;
	cd ..;
	echo
    fi
done
