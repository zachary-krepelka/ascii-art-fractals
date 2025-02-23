# Newton fractal

<!--
	FILENAME: README.md
	AUTHOR: Zachary Krepelka
	DATE: Friday, February 21st, 2025
	PATH: ascii-art-fractals/newton/README.md
	ABOUT: a project for the exploration of programming languages
	ORIGIN: https://github.com/zachary-krepelka/ascii-art-fractals.git
	UPDATED: Sunday, February 23rd, 2025 at 2:46 AM
-->

This directory contains various implementations of a [console application][1]
that renders a [Newton fractal][2] in [ANSI art][3].

## Overview

The program is intended for the command-line interface, and it is contained
within a single source file.  It takes no input and outputs a small ANSI art
image of a Newton fractal corresponding to the 3<sup>rd</sup>-degree polynomial
$p(z) = z^3 - 1$.

## Demo

To sample the default output of these programs, copy-and-paste this command into
your terminal.

```
wget -qO- https://raw.githubusercontent.com/zachary-krepelka/ascii-art-fractals/refs/heads/main/docs/images/newton.ans
```

## Backlog

I am planning some prospective features.

  * The program actually addresses the general case of an n<sup>th</sup>-degree,
    integer polynomial of a single variable.  The 3<sup>rd</sup>-degree
    polynomial is passed as a hard-coded argument to a function accepting the
    general case as a parameter.  Later I will consider expanding each of the
    program implementations to support command-line input.  Input could be
    supplied via a file as well.

  * Newton fractals can be shaded to indicate the rate of convergence of any
    complex number to a root.  This has the effect of making the images look
    more intricate.  Implementing this would entail transitioning from
    [4-bit][4] to [24-bit][5] color codes.  We would have to use the RGB
    construct `ESC[48;2;{r};{g};{b}m`.

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
[4]: https://en.wikipedia.org/wiki/ANSI_escape_code#3-bit_and_4-bit
[5]: https://en.wikipedia.org/wiki/ANSI_escape_code#24-bit
