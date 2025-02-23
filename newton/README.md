# Newton fractal

<!--
	FILENAME: README.md
	AUTHOR: Zachary Krepelka
	DATE: Friday, February 21st, 2025
	PATH: ascii-art-fractals/newton/README.md
	ABOUT: a project for the exploration of programming languages
	ORIGIN: https://github.com/zachary-krepelka/ascii-art-fractals.git
	UPDATED: Saturday, February 22nd, 2025 at 9:59 PM
-->

This directory contains various implementations of a [console application][1]
that renders a [Newton fractal][2] in [ANSI art][3].

The program is intended for the command-line interface, and it is contained
within a single source file.  It takes no input and outputs a small ANSI art
image of a Newton fractal corresponding to the 3<sup>rd</sup>-degree polynomial
$p(z) = z^3 - 1$.

The program actually addresses the general case of an n<sup>th</sup>-degree,
integer polynomial of a single variable.  The 3<sup>rd</sup>-degree polynomial
is passed as a hard-coded argument to a function accepting the general case as a
parameter.  Later I will consider expanding each of the program implementations
to support command-line input.

## Demo

To sample the output of these programs, copy-and-paste this command into your
terminal.

```
wget -qO- https://raw.githubusercontent.com/zachary-krepelka/ascii-art-fractals/refs/heads/main/docs/images/newton.ans
```

## Featured Languages

They are listed in the order that I wrote the programs with them.  I hope to
make this list longer in the coming year.

 1. Java
 2. JavaScript
 3. CoffeeScript
 4. Lua
 5. Python
 6. Ruby
 7. Julia
 8. PHP
 9. Kotlin
10. MATLAB

[1]: https://en.wikipedia.org/wiki/Console_application
[2]: https://en.wikipedia.org/wiki/Newton_fractal
[3]: https://en.wikipedia.org/wiki/ANSI_art
