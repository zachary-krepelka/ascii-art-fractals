=begin

 ___      _
| _ \_  _| |__ _  _
|   / || | '_ \ || |
|_|_\\_,_|_.__/\_, |
	       |__/

FILENAME: fractal.rb
AUTHOR: Zachary Krepelka
DATE: Sunday, October 29th, 2023

=end

def fractal(px, max, tol, poly, colors, roots)

	der = diff poly
	plane = make_plane px

 	px.times do |i|
 		px.times do |j|
			z = Complex *plane[i][j]
			converged = false
			max.times do
				colors.zip(roots).each do |pair|
					color, root = pair
					if z.dist(root) <= tol
						print color
						converged = true
						break
					end
				end
				break if converged
				z = newton poly, der, z
			end
 		end
		puts
 	end

end

def newton(poly, der, guess)
	guess - eval(poly, guess) / eval(der, guess)
end

def diff(poly)
	poly.each_with_index.map do |coeff, exp|
		coeff * exp
	end.drop(1)
end

def eval(poly, z)
	poly.each_with_index.map do |coeff, exp|
		coeff * z ** exp
	end.sum
end

class Complex

	def dist z
		(self - z).abs
	end
end

def make_plane(px)
	re = im = 0
	stride = 2.fdiv(px - 1)
	plane = array px, px, 2
	px.times do |i|
		px.times do |j|
			if j == 0
				re = -im = 1
			else
				re += stride
				im -= stride
			end
			plane[i][j][0] = re
			plane[j][i][1] = im
		end
	end
	plane
end

def deep_copy(array)

	return array unless array.respond_to? "map"
	array.map do |element|
		element.is_a?(Array) ? deep_copy(element) : element
	end
end

def array(*shape, initializer: 0)

	# This function initializes a multidimensional array.

		# 'shape' is a list of numbers
		# giving the size of the array
		# along each dimension

			# 'initializer' is the value
			# assumed by every element of
			# the array upon creation

	shape.reverse.inject initializer do |array, dimension|
		Array.new dimension do
			deep_copy array
		end
	end
end

=begin
	For example, calling 'array(2,3,4, initializer: 5)' produces this:

	[
	 	[
	 		[5, 5, 5, 5],
	 		[5, 5, 5, 5],
	 		[5, 5, 5, 5]
	 	],
	 	[
	 		[5, 5, 5, 5],
	 		[5, 5, 5, 5],
	 		[5, 5, 5, 5]
	 	]
	]

=end

polynomial = [-1, 0, 0, 1]

colors = "\033[41m  \033[0m", "\033[42m  \033[0m", "\033[44m  \033[0m"

roots = [ \
	Complex(1   ,  0                 ), \
	Complex(-0.5,  0.8660254037844386), \
	Complex(-0.5, -0.8660254037844386)]

fractal(25, 256, 0.001, polynomial, colors, roots)

#  UPDATED: Monday, December 4th, 2023   2:48 AM
