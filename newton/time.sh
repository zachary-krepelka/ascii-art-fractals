#!/usr/bin/env bash

# FILENAME: time.sh
# AUTHOR: Zachary Krepelka
# DATE: Tuesday, March 19th, 2024
# ABOUT: a project for the exploration of programming languages
# ORIGIN: https://github.com/zachary-krepelka/ascii-art-fractals.git

declare -A languages=(

	# key = the name of a programming language
	# value = the command to execute a file in that language

	[CoffeeScript]='coffee newton.coffee'
	[JavaScript]='node newton.js'
	[Java]='java Newton' # first run javac Newton.java
	[Julia]='julia newton.jl'
	[Kotlin]='kotlin NewtonKt' # first run kotlinc newton.kt
	[Lua]='lua newton.lua'
	[MATLAB]='cmd.exe /c matlab -nojvm -batch newton' # I'm on WSL.
	[PHP]='php newton.php'
	[Python]='python newton.py'
	[Ruby]='ruby newton.rb'

)

for i in "${!languages[@]}"
do
	printf "${i} "
	echo `{ time ${languages[$i]} ; } 2>&1 1>/dev/null` | cut -c 8-13

done | sort -k 2 | column -t -N LANGUAGE,TIME
