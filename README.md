# ascii-art-fractals

<!--
	FILENAME: README.md
	AUTHOR: Zachary Krepelka
	DATE: Wednesday, January 3rd, 2024
-->

My goal with this project is to *gain experience programming in different
languages.*  In this project, I implement the same program over and over again,
but each time, I do it in a different programming language.  The program is
simple enough for me to write on a weekend once I've learned the rudiments of a
language, but it's far more rewarding than a trivial `Hello, World!` program.  I
was inspired to pursue this project after reading [Programming Language
Explorations][1].

# Program Introduction

The program that I write is intended for the command-line interface, and it's
small enough to be contained within a single source file.  It takes no input[^1]
and outputs a small ASCII art image with ANSI coloring.  Namely, the program
generates a [Newton fractal][2] image corresponding to the 3<sup>rd</sup>-degree
polynomial $p(z) = z^3 - 1$.[^2]

# What's a Newton Fractal?

All you really need to know is that a fractal is a special kind of mathematical
pattern.  The output will look like this[^3], but in ASCII art:

<img src="newton-fractal.png" width=25% height=25%>

# Featured Languages

They are listed in the order that I wrote the programs with them.

1. Java
2. JavaScript
3. CoffeeScript
4. Lua
5. Python
6. Ruby
7. Julia

I hope to make this list longer in the coming year.

# Abbreviations

I use a number of abbreviations throughout this project.  Most are
self-explanatory.  I aim for brevity and simplicity in my naming choices.

| Abbreviation | Meaning                       |
| ------------ | ----------------------------- |
| abs          | absolute value                |
| coeff        | coefficient                   |
| der          | derivative                    |
| diff         | differentiate                 |
| dist         | distance                      |
| exp          | exponent                      |
| max          | maximum                       |
| poly         | polynomial                    |
| px           | pixel                         |
| re and im    | components of complex number  |
| tol          | tolerance                     |
| z and w      | denote complex numbers        |

<!-- References and Footnotes -->

[1]: https://rtoal.github.io/ple/
[2]: https://en.wikipedia.org/wiki/Newton_fractal

[^1]: Later I will consider expanding each of the program implementations to
support command-line input.  This will entail writing a basic command-line
argument parser in each language.

[^2]:The program actually addresses the general case of an
n<sup>th</sup>-degree, integer polynomial of a single variable.  The
3<sup>rd</sup>-degree polynomial is passed as a hard-coded argument to a
function accepting the general case as a parameter.

[^3]:I also wrote a full-fledged Newton fractal image generator, outputting
image files as apposed to text.  The featured image was generated with that
program.  Sooner or later, I will upload that to GitHub too.  Full details about
Newton fractals will be provided there.
