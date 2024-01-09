###

  ___      __  __         ___         _      _
 / __|___ / _|/ _|___ ___/ __| __ _ _(_)_ __| |_
| (__/ _ \  _|  _/ -_) -_)__ \/ _| '_| | '_ \  _|
 \___\___/_| |_| \___\___|___/\__|_| |_| .__/\__|
                                       |_|

FILENAME: fractal.coffee
AUTHOR: Zachary Krepelka
DATE: Wednesday, September 13th, 2023

###

fractal = (px, max, tol, poly, colors, roots) ->
	der = diff poly
	plane = makePlane px
	for i in [0...px]
		for j in [0...px]
			z = plane[i][j]
			converged = false
			for k in [0...max]
				for root, l in roots
					if (dist z, root) <= tol
						process.stdout.write colors[l]
						converged = true
						break
				break if converged
				z = newton poly, der, z
		process.stdout.write "\n"

makePlane = (px) ->
	re = im = 0
	stride = 2 / (px - 1)
	plane = array3D px, px, 2
	for i in [0...px]
		for j in [0...px]
			if j is 0
				re = -1; im = 1
			else
				re += stride
				im -= stride
			plane[i][j][0] = re
			plane[j][i][1] = im
	return plane

array3D = (x, y, z) ->
	arr = []
	for i in [0...x]
		arr[i] = []
		for j in [0...y]
			arr[i][j] = []
			for k in [0...z]
				arr[i][j][k] = null

newton = (poly, der, guess) ->
	sub(guess, div(evall(poly, guess), evall(der, guess)))

evall = (poly, z) -> # 'eval' is a keyword in CoffeeScript
	add (scl coeff, pow z, exp for coeff, exp in poly)...

diff = (poly) -> (coeff * exp for coeff, exp in poly)[1..]

dot = (z, w) -> (z[i] * w[i] for i in [0, 1]).reduce (a, b) -> a + b

scl = (n, z) -> n * part for part in z

add = (nums...) ->
	nums.reduce (total, curr) -> total[i] + curr[i] for i in [0, 1]

sub = (z, w) -> add z, scl -1, w

div = (z, w) ->
	re = z[0] * w[0] + z[1] * w[1]
	im = z[1] * w[0] - z[0] * w[1]
	scl (1 / dot w, w), [re, im]

abs = (z) -> Math.sqrt dot z, z

dist = (z, w) -> abs sub z, w

cis = (arg) -> f arg for f in [Math.cos, Math.sin]

arg = (z) -> Math.atan2 z[1], z[0]

pow = (z, n) -> scl (abs z)**n, cis n * arg z

colors = [ # uses ANSI escape codes
	"\x1B[41m  \x1B[0m" # red
	"\x1B[42m  \x1B[0m" # green
	"\x1B[44m  \x1B[0m" # blue
]

roots = [
	[ 1  ,  0                 ]
	[-0.5,  0.8660254037844386]
	[-0.5, -0.8660254037844386]
]

fractal 25, 256, 0.001, [-1, 0, 0, 1], colors, roots

#  UPDATED: Friday, November 24th, 2023   12:03 PM
