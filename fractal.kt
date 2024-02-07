/*

 _  __    _   _ _
| |/ /___| |_| (_)_ _
| ' </ _ \  _| | | ' \
|_|\_\___/\__|_|_|_||_|

FILENAME: fractal.kt
AUTHOR: Zachary Krepelka
ATE: Tuesday, February 6th, 2024
ORIGIN: https://github.com/zachary-krepelka/ascii-art-fractals.git

*/

import kotlin.math.atan2
import kotlin.math.cos
import kotlin.math.pow
import kotlin.math.sin
import kotlin.math.sqrt

fun fractal(

	px: Int,
	max: Int,
	tol: Double,
	poly: IntArray,
	colors: Array<String>,
	roots: Array<DoubleArray>
) {

	val der = diff(poly)
	val plane = makePlane(px)

	for (i in 0 until px) {
		for (j in 0 until px) {
			var z = plane[i][j]
			loop@ for (k in 0 until max) {
				for ((l, root) in roots.withIndex()) {
					if (dist(z, root) <= tol) {
						print(colors[l])
						break@loop
					} // if
				} // for
				z = newton(poly, der, z)
			} // for
		} // for
		println()
	} // for
} // func

fun makePlane(px: Int): Array<Array<DoubleArray>> {

	var re = 0.0; var im = 0.0
	val stride = 2.0 / (px.toDouble() - 1)
	var plane = array3D(px, px, 2)

	for (i in 0 until px) {
		for (j in 0 until px) {
			if (j == 0) {
				re = -1.0; im = 1.0
			} else {
				re += stride
				im -= stride
			} // if
			plane[i][j][0] = re
			plane[j][i][1] = im
		} // for
	} // for
	return plane
} // func

fun array3D(x: Int, y: Int, z: Int): Array<Array<DoubleArray>> {

	return Array(x, {_ -> Array(y, {_ -> DoubleArray(z)})})

} // func

fun newton(poly: IntArray, der: IntArray, guess: DoubleArray): DoubleArray {

	return sub(guess, div(eval(poly, guess), eval(der, guess)))

} // func

fun eval(poly: IntArray, z: DoubleArray): DoubleArray {

	var result = doubleArrayOf(0.0, 0.0)

	for ((exp, coeff) in poly.withIndex())

		result =

			add(
				result,
				scl(
					coeff.toDouble(),
					pow(
						z,
						exp.toDouble()
					)
				)
			)

	return result
} // func

fun diff(poly: IntArray): IntArray {

	var der = IntArray(poly.count())

	poly.forEachIndexed { exp, coeff -> der[exp] = exp * coeff }

	return der.drop(1).toIntArray()

} // func

val dot: (DoubleArray, DoubleArray) -> Double = {

	z, w -> z[0] * w[0] + z[1] * w[1]

} // lambda

val scl: (Double, DoubleArray) -> DoubleArray = {

	n, z -> doubleArrayOf(n * z[0], n * z[1])
} // lambda

val add: (DoubleArray, DoubleArray) -> DoubleArray = {

	z, w -> doubleArrayOf(z[0] + w[0], z[1] + w[1])

} // lambda

val sub: (DoubleArray, DoubleArray) -> DoubleArray = {

	z, w -> add(z, scl(-1.0, w))

} // lambda

val div: (DoubleArray, DoubleArray) -> DoubleArray = {

	z, w -> scl(1 / dot(w, w), doubleArrayOf(

		z[0] * w[0] + z[1] * w[1],
		z[1] * w[0] - z[0] * w[1]
	))
} // lambda

val abs: (DoubleArray) -> Double = {

	z -> sqrt(dot(z, z))

} // lambda

val dist: (DoubleArray, DoubleArray) -> Double = {

	z, w -> abs(sub(z, w))

} // lambda

val cis: (Double) -> DoubleArray = {

	arg -> doubleArrayOf(cos(arg), sin(arg))

} // lambda

val arg: (DoubleArray) -> Double = {

	z -> atan2(z[1], z[0])

} // lambda

val pow: (DoubleArray, Double) -> DoubleArray = {

	z, n -> scl(abs(z).pow(n), cis(n * arg(z)))

} // lambda

fun main() {

	val poly = intArrayOf(-1, 0, 0, 1)

	val colors = arrayOf( // uses ANSI escape codes

		"\u001b[41m  \u001b[0m", // red
		"\u001b[42m  \u001b[0m", // green
		"\u001b[44m  \u001b[0m"  // blue
	)

	val roots = arrayOf(

		doubleArrayOf( 1.0,  0.0             ),
		doubleArrayOf(-0.5,  sqrt(3.0) / 2.0 ),
		doubleArrayOf(-0.5, -sqrt(3.0) / 2.0 )
	)

	fractal(25, 256, 0.01, poly, colors, roots)

} // entry

// UPDATED: Wednesday, February 7th, 2024 at 1:07 AM
