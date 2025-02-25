#!/usr/bin/env bash

# FILENAME: time.sh
# AUTHOR: Zachary Krepelka
# DATE: Tuesday, March 19th, 2024
# UPDATED: Friday, February 21st, 2025 at 8:22 AM
# ABOUT: a project for the exploration of programming languages
# ORIGIN: https://github.com/zachary-krepelka/ascii-art-fractals.git

langs=(
	'Java'
	'JavaScript'
	'CoffeeScript'
	'Lua'
	'Python'
	'Ruby'
	'Julia'
	'PHP'
	'Kotlin'
	'MATLAB'
	'bc'
)

for lang in ${langs[@]}
do
	printf "$lang "

	lang=$(tr '[A-Z]' '[a-z]' <<< $lang)

	echo $({ time make $lang ; } 2>&1 >/dev/null) | cut -c 8-13

done | sort -k 2 | column -t -N LANGUAGE,TIME
