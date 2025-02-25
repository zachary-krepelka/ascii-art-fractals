# FILENAME: makefile
# AUTHOR: Zachary Krepelka
# DATE: Wednesday, July 10th, 2024
# ABOUT: a project for the exploration of programming languages
# ORIGIN: https://github.com/zachary-krepelka/ascii-art-fractals.git
# UPDATED: Friday, February 21st, 2025 at 8:25 AM

java:
	javac Newton.java && java Newton

javascript:
	node newton.js

coffeescript:
	coffee newton.coffee

lua:
	lua newton.lua

python:
	python newton.py

ruby:
	ruby newton.rb

julia:
	julia newton.jl

php:
	php newton.php

kotlin:
	kotlinc newton.kt && kotlin NewtonKt

matlab:
	cmd.exe /c matlab -nojvm -batch newton

SHELL = bash
.ONESHELL:
bc:
	sed -f - <(bc -ql newton.bc) << COLORIZATION_SCRIPT
	y/0123/?abc/
	s/\(?\+\)/\d27[30m\1\d27[0m/g
	s/\(a\+\)/\d27[41m\1\d27[0m/g
	s/\(b\+\)/\d27[42m\1\d27[0m/g
	s/\(c\+\)/\d27[44m\1\d27[0m/g
	s/[abc?]/ /g
	COLORIZATION_SCRIPT
