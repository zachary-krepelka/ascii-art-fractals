#=

    _      _ _
 _ | |_  _| (_)__ _
| || | || | | / _` |
 \__/ \_,_|_|_\__,_|

FILENAME: newton.jl
AUTHOR: Zachary Krepelka
DATE: Saturday, December 2nd, 2023
ABOUT: a project for the exploration of programming languages
ORIGIN: https://github.com/zachary-krepelka/ascii-art-fractals.git
UPDATED: Sunday, October 26th, 2025 at 12:38 PM

=#

function fractal(px, max, tol, poly, colors, roots)

	der = diff(poly)

	stride = 2 / (px - 1)
	plane = [ a + b * im for b in 1:-stride:-1, a in -1:stride:1 ]
	unresolved = colors[end]

	for i in 1:px
		for j in 1:px
			z = plane[i, j]
			converged = false
			for _ in 1:max
				for pair in zip(colors, roots)
					color, root = pair
					if dist(z, root) <= tol
						print(color)
						converged = true
						break
					end
				end
				converged && break
				z = newton(poly, der, z)
			end
                        !converged && print(unresolved)
		end
		println()
	end
end

function newton(poly, der, guess)
	guess - evall(poly, guess) / evall(der, guess)
end

function diff(poly)
	map(enumerate(poly[2:end])) do term
		exp, coeff = term
		exp * coeff
	end
end

function evall(poly, z)
	mapreduce(+, enumerate(poly)) do term
	    exp, coeff = term
	    exp -= 1
	    coeff * z ^ exp
	end
end

dist(z, w) = abs(z - w)

polynomial = [-1, 0, 0, 1]

colors = [ # uses ANSI escape codes
	  "\033[41m  \033[0m" # red
	  "\033[42m  \033[0m" # green
	  "\033[44m  \033[0m" # blue
	  "\033[40m  \033[0m" # black to signify the void
]

roots = [ 1
	 -1/2 + sqrt(3) / 2 * im
	 -1/2 - sqrt(3) / 2 * im
]

fractal(25, 256, 0.001, polynomial, colors, roots)
