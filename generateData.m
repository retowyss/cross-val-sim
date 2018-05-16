function [y, x] = generateData(p, n)
% Generate a dataset of size n given a polynomial
x = rand(n, 1);
y = polyval(p, x);

endfunction
