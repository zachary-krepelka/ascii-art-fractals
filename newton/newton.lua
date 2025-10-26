--[[

 _
| |  _  _ __ _
| |_| || / _` |
|____\_,_\__,_|

FILENAME: newton.lua
AUTHOR: Zachary Krepelka
DATE: Tuesday, September 26th, 2023
ABOUT: a project for the exploration of programming languages
ORIGIN: https://github.com/zachary-krepelka/ascii-art-fractals.git
UPDATED: Sunday, October 26th, 2025 at 11:51 AM

--]]

function fractal(px, max, tol, poly, colors, roots)
	der = diff(poly)
	unresolved = colors[#colors]
	for _ = 1, px do
		for _ = 1, px do
			local _, z = coroutine.resume(nextComplex, px)
			converged = false
			for k = 1, max do
				for l = 1, #roots do
					if z:dist(roots[l]) <= tol then
						io.write(colors[l])
						converged = true
						break
					end
				end
				if converged then break end
				z = z:newton(poly, der)
			end
			if not converged then
				io.write(unresolved)
			end
		end
		print()
	end
end

function array3D(x, y, z)
	array = {}
	for i = 0, x - 1 do
		array[i] = {}
		for j = 0, y - 1 do
			array[i][j] = {}
			for k = 0, z - 1 do
				array[i][j][k] = 0
					end end end
						return array
							end

function makePlane(px)
	stride = 2 / (px - 1)
	plane = array3D(px, px, 2)
	for i = 0, px - 1 do
		for j = 0, px - 1 do
			if j == 0 then
				re, im = -1, 1
			else
				re = re + stride
				im = im - stride
			end
			plane[i][j][0] = re
			plane[j][i][1] = im
		end
	end
	return plane
end

nextComplex = coroutine.create(
	function (px)
		plane = makePlane(px)
		for i = 0, px - 1 do
			for j = 0, px - 1 do
				coroutine.yield(
					Complex:new(
						plane[i][j][0],
						plane[i][j][1]
					))
			end
		end
	end)

-- function printArray3D(arr)
-- 	print("[")
-- 	for i = 0, #arr do
-- 		io.write("  [ ")
-- 		for j = 0, #arr[i] do
-- 			io.write("[ ")
-- 			for k = 0, #arr[i][j] do
-- 				delimiter = k == #arr[i][j] and " " or ", "
-- 				io.write(arr[i][j][k], delimiter)
-- 			end
-- 			delimiter = j == #arr[i] and " " or ", "
-- 			io.write("]", delimiter)
-- 		end
-- 		delimiter = i == #arr and " " or ", "
-- 		io.write("]", delimiter, "\n")
-- 	end
-- 	print("]")
-- end

Complex = {re = 0, im = 1}

function Complex:new(real, imaginary)
	local z = {}
	setmetatable(z, self)
	self.__index = self
	z.re = real or 0
	z.im = imaginary or 0
	return z
end

function Complex:dot(z)
	return self.re * z.re + self.im * z.im
end

function Complex:scale(n)
	return Complex:new(n * self.re, n * self.im)
end

function Complex:__unm()
	return Complex:new(-self.re, -self.im)
end

function Complex:__add(z)
	return Complex:new(self.re + z.re, self.im + z.im)
end

function Complex:__sub(z)
	return self + -z
end


function Complex:__div(z)
	re = self.re * z.re + self.im * z.im
	im = self.im * z.re - self.re * z.im
	return (Complex:new(re, im)):scale(1/z:dot(z))
end

function Complex:abs()
	return math.sqrt(self:dot(self))
end

function Complex:dist(z)
	return (self - z):abs()
end

function Complex:__tostring()
	return self.re .. " + " .. self.im .. "i"
end

function Complex:cis(arg)
	return Complex:new(math.cos(arg), math.sin(arg))
end

function Complex:arg()
	return math.atan2(self.im, self.re)
end

function Complex:pow(n)
	return Complex:cis(n * self:arg()):scale(self:abs()^n)
end

function Complex:eval(poly)
	local sum = Complex:new(0,0)
	for i = 0, #poly - 1 do
		sum = sum + self:pow(i):scale(poly[i + 1])
	end
	return sum
end

function diff(poly)
	local der = {}
	for i = 1, #poly - 1 do
		table.insert(der, poly[i + 1] * i)
	end
	return der
end

function Complex:newton(poly, der)
	return self - self:eval(poly) / self:eval(der)
end

colors = {
	"\x1B[41m  \x1B[0m", -- red
	"\x1B[42m  \x1B[0m", -- green
	"\x1B[44m  \x1B[0m", -- blue
	"\x1B[40m  \x1B[0m"  -- black to signify the void
}

roots = {
	Complex:new( 1  ,  0                 ),
	Complex:new(-0.5,  0.8660254037844386),
	Complex:new(-0.5, -0.8660254037844386)
}

fractal(25, 256, 0.001, {-1, 0, 0, 1}, colors, roots)
