# FILENAME: makefile
# AUTHOR: Zachary Krepelka
# DATE: Wednesday, July 10th, 2024
# ABOUT: a project for the exploration of programming languages
# ORIGIN: https://github.com/zachary-krepelka/ascii-art-fractals.git
# UPDATED: Sunday, October 26th, 2025 at 1:52 PM

# Goals ------------------------------------------------------------------- {{{1

java: Newton.class
	java Newton

javascript:
	node newton.js

coffeescript:
	coffee newton.coffee

lua:
	lua newton.lua

python:
	python3 newton.py

ruby:
	ruby newton.rb

julia:
	julia newton.jl

php:
	php newton.php

kotlin: NewtonKt.class
	kotlin NewtonKt

matlab:
	# using Window's Subsystem for Linux
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

# Prerequisites ----------------------------------------------------------- {{{1

Newton.class: newton.java
	javac newton.java

NewtonKt.class: newton.kt
	kotlinc newton.kt

# Housekeeping ------------------------------------------------------------ {{{1

.PHONY: clean

clean:
	rm -rf META-INF/
	find . -type f -name '*.class' -exec rm {} \;

# vim: tw=80 ts=8 sw=8 noet fdm=marker
