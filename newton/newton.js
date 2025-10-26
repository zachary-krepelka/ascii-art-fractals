/*

    _               ___         _      _
 _ | |__ ___ ____ _/ __| __ _ _(_)_ __| |_
| || / _` \ V / _` \__ \/ _| '_| | '_ \  _|
 \__/\__,_|\_/\__,_|___/\__|_| |_| .__/\__|
                                 |_|

FILENAME: newton.js
AUTHOR: Zachary Krepelka
DATE: Sunday, September 10th, 2023
ABOUT: a project for the exploration of programming languages
ORIGIN: https://github.com/zachary-krepelka/ascii-art-fractals.git
UPDATED: Sunday, October 26th, 2025 at 11:35 AM

*/

function fractal(px, max, tol, poly, colors, roots) {
	const der = diff(poly);
	const plane = makePlane(px);
	const unresolved = colors[colors.length - 1];
	for (let i = 0; i < px; i++) {
		for (let j = 0; j < px; j++) {
			let converged = false;
			let z = plane[i][j]; LOOP:
			for (let k = 0; k < max; k++) {
				for (let l = 0; l < roots.length; l++) {
					if (dist(z, roots[l]) <= tol) {
						converged = true;
						process.stdout.write(colors[l]);
						break LOOP;
					} // if
				} // for
				z = newton(poly, der, z);
			} // for
			if (!converged)
				process.stdout.write(unresolved);
		} // for
		process.stdout.write("\n");
	} // for
} // func

function makePlane(px) {
	let re = 0, im = 0;
	const stride = 2 / (px - 1);
	const plane = array3D(px, px, 2);
	for (let i = 0; i < px; i++) {
		for (let j = 0; j < px; j++) {
			if (j == 0) {
				re = -1; im = 1;
			} else {
				re += stride;
				im -= stride;
			} // if
			plane[i][j][0] = re;
			plane[j][i][1] = im;
		} // for
	} // for
	return plane;
} // func

function array3D(x, y, z) {
	const arr = [];
	for (let i = 0; i < x; i++) {
		arr.push([]);
		for (let j = 0; j < y; j++) {
			arr[i].push([]);
			for (let k = 0; k < z; k++) {
				arr[i][j][k] = null;
			} // for
		} // for
	} // for
	return arr;
} // func

newton = (poly, der, guess) =>
	sub(guess, div(eval(poly, guess), eval(der, guess)));

eval = (poly, z) =>
	poly.map((coeff, exp) => scl(coeff, pow(z, exp)))
	.reduce((sum, term) => add(sum, term));

diff = poly => poly.map((coeff, exp) => coeff * exp).slice(1);

dot = (z, w) => z[0] * w[0] + z[1] * w[1];

scl = (n, z) => [n * z[0], n * z[1]];

add = (z, w) => [z[0] + w[0], z[1] + w[1]];

sub = (z, w) => add(z, scl(-1, w));

div = (z, w) => {
	const re = z[0] * w[0] + z[1] * w[1];
	const im = z[1] * w[0] - z[0] * w[1];
	return scl(1/dot(w, w), [re, im]);};

abs = z => Math.sqrt(dot(z, z));

dist = (z, w) => abs(sub(z, w));

cis = arg => [Math.cos(arg), Math.sin(arg)];

arg = z => Math.atan2(z[1], z[0]);

pow = (z, n) => scl(abs(z) ** n, cis(n * arg(z)));

fractal(
	25, 256, 0.001,
	[-1, 0, 0, 1],
	[ // uses ANSI escape codes
		"\033[41m  \033[0m", // red
		"\033[42m  \033[0m", // green
		"\033[44m  \033[0m", // blue
		"\033[40m  \033[0m"  // black to signify the void
	],
	[
		[ 1  ,  0                 ],
		[-0.5,  0.8660254037844386],
		[-0.5, -0.8660254037844386]
	]
);
