/*

    _
 _ | |__ ___ ____ _
| || / _` \ V / _` |
 \__/\__,_|\_/\__,_|

FILENAME: Fractal.java
AUTHOR: Zachary Krepelka
DATE: Friday, September 8th, 2023

*/

public class Fractal {

	private static void fractal(
		int px,
		int max,
		double tol,
		int[] poly,
		String[] colors,
		double[][] roots
	) {
		int[] der = diff(poly);
		double[][][] plane = makePlane(px);
		for (int i = 0; i < px; i++) {
			for (int j = 0; j < px; j++) {
				double[] z = plane[i][j]; LOOP:
				for (int k = 0; k < max; k++) {
					for (int l = 0; l < roots.length; l++) {
						if (dist(z, roots[l]) <= tol) {
							System.out.print(
							colors[l]);
							break LOOP;
						} //if
					} //for
					z = newton(poly, der, z);
				} //for
			} //for
		System.out.println();
		} //for
	} //method

	private static double[][][] makePlane(int px) {
		double re = 0, im = 0;
		double stride =  2 / ((double) px - 1);
		double[][][] plane = new double[px][px][2];
		for (int i = 0; i < px; i++) {
			for (int j = 0; j < px; j++) {
				if (j == 0) {
					re = -1; im = 1;
				} else {
					re += stride;
					im -= stride;
				} //if
				plane[i][j][0] = re;
				plane[j][i][1] = im;
			} //for
		} //for
		return plane;
	} //method

	private static double[] newton(int[] poly, int[] der, double[] guess) {
		return sub(guess, div(eval(poly, guess), eval(der, guess)));
	} //method

	private static double[] eval(int[] poly, double[] z) {
		double[] sum = new double[2];
		for (int i = 0; i < poly.length; i++)
			sum = add(sum, scl(poly[i], pow(z, i)));
		return sum;
	} // method

	private static int[] diff(int[] poly) {
		int[] der = new int[poly.length - 1];
		for (int i = 0; i < der.length; i++)
			der[i] = poly[i + 1] * (i + 1);
		return der;
	} //method

	private static double dot(double[] z, double[] w) {
		return z[0] * w[0] + z[1] * w[1];
	} //method

	private static double[] scl(double n, double[] z) {
		return new double[] {n * z[0], n * z[1]};
	} //method

	private static double[] add(double[] z, double[] w) {
		return new double[] {z[0] + w[0], z[1] + w[1]};
	} //method

	private static double[] sub(double[] z, double[] w) {
		return add(z, scl(-1, w));
	} //method

	private static double[] div(double[] z, double[] w) {
		double re = z[0] * w[0] + z[1] * w[1];
		double im = z[1] * w[0] - z[0] * w[1];
		return scl(1 / dot(w, w), new double[] {re, im});
	} //method

	private static double abs(double[] z) {
		return Math.sqrt(dot(z, z));
	} //method

	private static double dist(double[] z1, double[] z2) {
		return abs(sub(z1, z2));
	} //method

	private static double[] cis(double arg) {
		return new double[] {Math.cos(arg), Math.sin(arg)};
	} //method

	private static double arg(double[] z) {
		return Math.atan2(z[1], z[0]);
	} //method

	private static double[] pow(double[] z, double n) {
		return scl(Math.pow(abs(z), n), cis(n * arg(z)));
	} //method

	public static void main(String[] args) {

		fractal(
			25, 256, 0.001,
			new int[] {-1, 0, 0, 1},
			new String[] { // uses ANSI escape codes
				"\033[41m  \033[0m",  // red
				"\033[42m  \033[0m",  // green
				"\033[44m  \033[0m"}, // blue
			new double[][] {
				{ 1  ,  0                 },
				{-0.5,  0.8660254037844386},
				{-0.5, -0.8660254037844386}}
		);

	} //main

} //class

// UPDATED: Friday, November 24th, 2023   12:03 PM
