%{

 __  __   _ _____ _      _   ___
|  \/  | /_\_   _| |    /_\ | _ )
| |\/| |/ _ \| | | |__ / _ \| _ \
|_|  |_/_/ \_\_| |____/_/ \_\___/

FILENAME: newton.m
AUTHOR: Zachary Krepelka
DATE: Sunday, March 3rd, 2024
ABOUT: a project for the exploration of programming languages
ORIGIN: https://github.com/zachary-krepelka/ascii-art-fractals.git
UPDATED: Tuesday, March 19th, 2024 at 12:04 AM

%}

function newton()

	tic

	fractal(25, 256, 0.001, [1 0 0 -1], [

		"\033[41m  \033[0m" % Red
		"\033[42m  \033[0m" % Green
		"\033[44m  \033[0m" % Blue
		"\033[40m  \033[0m" % Black, to signify the void.

	], roots([1 0 0 -1]))

	toc

end

function fractal(px, max, tol, poly, colors, roots)

	dist = @(z, w) abs(z - w);

	newton = @(poly, der, guess) ...
		guess - polyval(poly, guess) / polyval(der, guess);

	der = polyder(poly);
	plane = makePlane(px);

	for i = 1 : px
		for j = 1 : px
			z = plane(i, j);
			converged = false;
			for k = 0 : max
				for l = 1 : size(roots)
					if dist(z, roots(l)) <= tol
						fprintf(colors(l))
						converged = true;
						break
					end
				end
				if converged, break, end
				z = newton(poly, der, z);
			end
			if ~converged
				% print default value
				fprintf(colors(end))
			end
		end
		fprintf("\n")
	end
end

function plane = makePlane(px)

	[a, b] = meshgrid(-1 : 2 / (px - 1) : 1);

	plane = a + b * i;

end

% This file must run in a terminal. To run from cmd.exe, try this:

	% matlab -nojvm -batch newton

% The command must be issued in the same directory where the file is located.
% Otherwise, specify the full path like this:

% matlab -nojvm -batch "run('C:\Users\<whoever>\<wherever>\newton.m')"
