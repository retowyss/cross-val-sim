function [y, x] = dataGen(p, n)
  x = rand(n, 1);
  y = polyval(p, x);
endfunction
