<?php /*

 ___ _  _ ___
| _ \ || | _ \
|  _/ __ |  _/
|_| |_||_|_|

FILENAME: newton.php
AUTHOR: Zachary Krepelka
DATE: Saturday, January 27th, 2024
ABOUT: a project for the exploration of programming languages
ORIGIN: https://github.com/zachary-krepelka/ascii-art-fractals.git
UPDATED: Sunday, October 26th, 2025 at 12:43 PM

*/

function fractal($px, $max, $tol, $poly, $colors, $roots) {
	global $dist;
	$der = diff($poly);
	$plane = makePlane($px);
	$unresolved = end($colors);
	for ($i = 0; $i < $px; $i++) {
		for ($j = 0; $j < $px; $j++) {
			$converged = False;
			$z = $plane[$i][$j];
			for ($k = 0; $k < $max; $k++) {
				foreach ($roots as $l => $root) {
					if ($dist($z, $root) <= $tol) {
						$converged = True;
						echo $colors[$l];
						break 2;
					} // if
				} // foreach
				$z = newton($poly, $der, $z);
			} // for
			if (!$converged)
				echo $unresolved;
		} // for
		echo "\n";
	} // for
} // func

function makePlane($px) {
	$re = $im = 0;
	$stride = 2 / ($px - 1);
	for ($i = 0; $i < $px; $i++) {
		for ($j = 0; $j < $px; $j++) {
			if ($j == 0) {
				$re = -$im = 1;
			} else {
				$re += $stride;
				$im -= $stride;
			} // if
			$plane[$i][$j][0] = $re;
			$plane[$j][$i][1] = $im;
		} // for
	} // for
	return $plane;
} // func

function newton($poly, $der, $guess) {
	global $sub, $div;
	return $sub($guess, $div(evall($poly, $guess), evall($der, $guess)));
} // func

function evall($poly, $z) {
	global $add, $scl, $pow; $result = [0, 0];
	foreach ($poly as $exp => $coeff)
		$result = $add($result, $scl($coeff, $pow($z, $exp)));
	return $result;
} // func

function diff($poly) {
	foreach ($poly as $exp => $coeff)
		$poly[$exp] = $exp * $coeff;
	array_shift($poly);
	return $poly;
} // func

$dot = fn($z, $w) => $z[0] * $w[0] + $z[1] * $w[1];

$scl = fn($n, $z) => [$n * $z[0], $n * $z[1]];

$add = fn($z, $w) => [$z[0] + $w[0], $z[1] + $w[1]];

$sub = fn($z, $w) => $add($z, $scl(-1, $w));

$div = fn($z, $w) =>
	$scl(1 / $dot($w, $w),
	[
		$z[0] * $w[0] + $z[1] * $w[1],
		$z[1] * $w[0] - $z[0] * $w[1]
	]);

$abs = fn($z) => sqrt($dot($z, $z));

$dist = fn($z, $w) => $abs($sub($z, $w));

$cis = fn($arg) => [cos($arg), sin($arg)];

$arg = fn($z) => atan2($z[1], $z[0]);

$pow = fn($z, $n) => $scl($abs($z) ** $n, $cis($n * $arg($z)));

/* unnecessary

function array3D($x, $y, $z, $initializer = null) {
	$arr = [];
	for ($i = 0; $i < $x; $i++) {
		$arr[] = [];
		for ($j = 0; $j < $y; $j++) {
			$arr[$i][] = [];
			for ($k = 0; $k < $z; $k++) {
				$arr[$i][$j][$k] = $initializer;
			} // for
		} // for
	} // for
	return $arr;
} // func

 */

fractal(
	25, 256, 0.001,
	array(-1, 0, 0, 1),
	[
		// uses ANSI escape codes
		"\033[41m  \033[0m", // red
		"\033[42m  \033[0m", // green
		"\033[44m  \033[0m", // blue
		"\033[40m  \033[0m"  // black to signify the void
	], [
		[ 1  ,  0                 ],
		[-0.5,  0.8660254037844386],
		[-0.5, -0.8660254037844386]
	]
);
