Spectrum
========

Spectrum is a preprocessor for the [PRISM][prism] model checking language.

PRISM is a great model checker, but misses out on some syntactic sugar that would make it a little sweeter to work with. Spectrum reads in those sweeter files, and outputs a translated PRISM file instead.

Currently, Spectrum supports:
* Array expansion

Array expansion
---------------
Arrays are defined by adding square brackets with the array length after the declaration, C/Java style. An array is initialized to all the same value. For example:

	x[3] : [0..2] init 1
	
Initializes an array of length 3, with possible values 0, 1 or 2, with the starting value as 1.

Continuing the C/Java convention, arrays begin from 0, so we can access `x[0]`, `x[1]` or `x[2]`. Here's a longer example:

	[] x[0] != 2 -> (x[0]' = 2);
	
Also supported are 2D arrays, with predictable syntax:

	x[3][3] : [0..2] init 1

and:

	[] x[0][2] != 2 -> (x[0][2]' = 2);
	
This is implemented by expanding the array values out, using `__` as a separator. For example, `x[1][1]` becomes `x__1__1`. Whether you use 2D arrays or not, the expansion will always be into two numbers. A 1D array expands with a zero at the end: `x__1__0`. You can think of this as a 1D array being identical to a 2D array with a length of one.

Example
-------
A longer example is given in the `tic_tac_toe.sm` file. Don't treat this as "good" PRISM code (it abuses the math of a CTMC quite badly), but it does illustrate how much cleaner the code becomes.

[prism]: http://www.prismmodelchecker.org