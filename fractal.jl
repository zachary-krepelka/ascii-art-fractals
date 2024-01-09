#=

    _      _ _
 _ | |_  _| (_)__ _
| || | || | | / _` |
 \__/ \_,_|_|_\__,_|

FILENAME: fractal.jl
AUTHOR: Zachary Krepelka
DATE: Saturday, December 2nd, 2023

=#

function fractal(px, max, tol, poly, colors, roots)

	der = diff(poly)

	stride = 2 / (px - 1)
	plane = [ a + b * im for b in 1:-stride:-1, a in -1:stride:1 ]

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
			!converged && print(colors[end]) # Default
		end
		println()
	end
end

function newton(poly, der, guess)
	guess - eval(poly, guess) / eval(der, guess)
end

function diff(poly)
	map(enumerate(poly[2:end])) do term
		exp, coeff = term
		exp * coeff
	end
end

function eval(poly, z)
	mapreduce(+, enumerate(poly)) do term
	    exp, coeff = term
	    exp -= 1
	    coeff * z ^ exp
	end
end

dist(z, w) = abs(z - w)

polynomial = [-1, 0, 0, 1]

colors = [
	  "\033[41m  \033[0m"
	  "\033[42m  \033[0m"
	  "\033[44m  \033[0m"
	  "\033[40m  \033[0m" # The end is a default value.
]

roots = [ 1
	 -1/2 + sqrt(3) / 2 * im
	 -1/2 - sqrt(3) / 2 * im
]

fractal(25, 256, 0.001, polynomial, colors, roots)
