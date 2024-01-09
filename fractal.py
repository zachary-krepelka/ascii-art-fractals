'''

 ___      _   _
| _ \_  _| |_| |_  ___ _ _
|  _/ || |  _| ' \/ _ \ ' \
|_|  \_, |\__|_||_\___/_||_|
     |__/

FILENAME: fractal.py
AUTHOR: Zachary Krepelka
DATE: Saturday, October 21st, 2023

'''

def fractal(px, max, tol, poly, colors, roots):

	der = diff(poly)
	plane = makePlane(px)

	for i in range(px):
		for j in range(px):
			z = complex(*plane[i][j])
			converged = False
			for k in range(max):
				for l in range(len(roots)):
					if dist(z, roots[l]) <= tol:
						print(colors[l], end="")
						converged = True
						break
				if converged: break
				z = newton(poly, der, z)
		print()

def newton(poly, der, guess):
	return guess - eval(poly, guess) / eval(der, guess)

def diff(poly):
	return [ coeff * exp for exp, coeff in enumerate(poly)][1:]

def eval(poly, z):
	return sum([coeff * pow(z, exp) for exp, coeff in enumerate(poly)])

def dist(z, w):
	return abs(z - w)

def makePlane(px):
	re = im = 0
	stride = 2 / (px - 1)
	plane = array(px, px, 2)
	for i in range(px):
		for j in range(px):
			if j == 0:
				re, im = -1, 1
			else:
				re += stride
				im -= stride
			plane[i][j][0] = re
			plane[j][i][1] = im
	return tuple(plane)

from copy import deepcopy as duplicate

def array(*shape):

	# This function zero-initializes a multidimensional array.

	# shape is a tuple of numbers
	# giving the size of the array
	# along each dimension

	array = 0

	for i in reversed(shape):
		array = [ duplicate(array) for _ in range(i) ]

	return array

		# For example, array(2,3,4) produces this:

		#	[
		#	 	[
		#	 		[0, 0, 0, 0],
		#	 		[0, 0, 0, 0],
		#	 		[0, 0, 0, 0]
		#	 	],
		#	 	[
		#	 		[0, 0, 0, 0],
		#	 		[0, 0, 0, 0],
		#	 		[0, 0, 0, 0]
		#	 	]
		#	]

polynomial = (-1, 0, 0, 1)

colors = "\033[41m  \033[0m", "\033[42m  \033[0m", "\033[44m  \033[0m"

roots = (
	complex(1   ,  0                 ),
	complex(-0.5,  0.8660254037844386),
	complex(-0.5, -0.8660254037844386))

fractal(25, 256, 0.001, polynomial, colors, roots)

#  UPDATED: Friday, November 24th, 2023   12:04 PM
