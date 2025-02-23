# ascii-art-fractals

<!--
	FILENAME: README.md
	AUTHOR: Zachary Krepelka
	DATE: Wednesday, January 3rd, 2024
	ABOUT: a project for the exploration of programming languages
	ORIGIN: https://github.com/zachary-krepelka/ascii-art-fractals.git
	UPDATED: Saturday, February 22nd, 2025 at 9:40 PM
-->

This repository contains a class of console applications implemented across
different programming languages.  These programs all serve the common purpose of
rendering ASCII art representations of [fractals][1].

> A fractal is a never-ending pattern.  Fractals are infinitely complex patterns
> that are self-similar across different scales.  They are created by repeating
> a simple process over and over in an ongoing feedback loop.  Driven by
> recursion, fractals are images of dynamic systems – the pictures of Chaos.

This was a definition by the [Fractal Foundation][2].

## Overview

The top-level directories in this repository each correspond to a particular
fractal.  Each file within a given directory is a single-file source-code
implementation of a program that renders that fractal.  The basename of each
file is the name of the directory in which the file is contained.  The file
extension serves to differentiate the programs, indicating the implementation
language.  The file structure is like this.

```graphql
repo/
|-- fractal-one/
|   |-- fractal-one.lang1
|   |-- fractal-one.lang2
|   |-- fractal-one.lang3
|   `-- ...
|-- fractal-two/
|   |-- fractal-two.lang1
|   |-- fractal-two.lang2
|   |-- fractal-two.lang3
|   `-- ...
`-- and-so-on/
```

Each directory also contains its own `README.md` and a `makefile`.

## Implementations

The various program implementations are accounted for in the following table.
The columns indicate fractals, and the rows indicate languages.  A check mark
indicates that a renderer have been implemented for a particular fractal in a
particular language.  It is clear that so far I have only worked on Newton
fractal renderers.  My intention is to write other fractal renderers in the
future.

<div align="center">

| Language     | Newton  | Mandlebrot | Sierpinski |
| :------------| :----:  | :--------: | :--------: |
| Java         | &check; |            |            |
| JavaScript   | &check; |            |            |
| CoffeeScript | &check; |            |            |
| Lua          | &check; |            |            |
| Python       | &check; |            |            |
| Ruby         | &check; |            |            |
| Julia        | &check; |            |            |
| PHP          | &check; |            |            |
| Kotlin       | &check; |            |            |
| MATLAB       | &check; |            |            |

</div>

## Motive

I was inspired to pursue this project after reading [Programming Language
Explorations][3], a programming book which showcases the same trio of programs
implemented across a variety of different languages.  This repository began as I
side project while I was taking a class called 'Programming Languages' taught by
Dr. Dan Wetklow at Saint Francis University.

My goal with this project is to *gain experience programming in different
languages.*  In this project, I implement the same class of programs over and
over again, but each time, I do it in a different programming language.  The
programs are simple enough for me to write on a weekend once I've learned the
rudiments of a language, and they each serve as a 'Hello, World!'.

## Constraints

My aim is not to merely translate the same set of programs into several
languages.  Instead, I strive to understand the design choices and unique
idiosyncrasies of each language.  When I implement the programs in Python, I aim
to be [Pythonic][4].  When I implement the programs in Ruby, I strive to [walk
along the path to enlightenment][5].  I put a great deal of effort into learning
each language and its design philosophy.

So as not to cheat myself out of learning opportunities, I try to avoid using
third-party packages where I can, instead preferring to write the code myself or
to only use a language's core libraries.  For example, in
[newton.py](../newton/newton.py) I dynamically initialize my own
multidimensional arrays instead of relying on packages like [NumPy][6] to do
this for me.

## Related

Kevin Newton's [tree repository][7] contains implementations of the Unix [tree
command][8] in a variety of different programming languages.  It is similar to
this repository in nature and intent.

[1]: https://en.wikipedia.org/wiki/Fractal
[2]: https://fractalfoundation.org/resources/what-are-fractals
[3]: https://rtoal.github.io/ple
[4]: https://en.wiktionary.org/wiki/Pythonic#Adjective_2
[5]: https://www.rubykoans.com
[6]: https://numpy.org
[7]: https://github.com/kddnewton/tree
[8]: https://en.wikipedia.org/wiki/Tree_(command)
