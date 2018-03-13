function [ rmses ] = crossVal( x, y, modfit, modpre, modparams, folds )
% Prototype: crossVal( x, y, modfit, modpre, modparams, folds)
%
% [ in ]
% 
% @param {x}         matrix (n x m)
% @param {y}         matrix (n x 1)
% @param {modfit}    function handle, given subsets of {x} and {y} and the i-th
%                    row of {modparams} fits a model: x -> y; 
%                    e.g. polyfit
% @param {modpre}    function handle, given a model and x predicts yhat; 
%                    e.g. polyval
% @param {modparams} matrix, set of parameters to pass to modfit; 
%                    in case of polyfit this is a (i x 1) matrix of intergers
%                    corresponding to polyfit's n-argument
% @param {folds}     matrix (k x 1) of integers, 
%
% [ out ]
% 
% @return {rmses}    matrix (length({folds}) x length({modparams})) 
%


% validating function arguments
assert(nargin == 6);
assert(typeinfo(x) == "matrix");
assert(typeinfo(y) == "matrix");
assert(typeinfo(modfit) == "function handle");
assert(typeinfo(modpre) == "function handle");
assert(ndims(x) == 2 && ndims(y) == 2);

xRows = rows(x);
yRows = rows(y);
nModels = length(modparams);
kLength = length(folds);

assert(xRows == yRows);
assert(xRows >= max(folds));
assert(all(folds >= 2))
assert(nModels > 0, "{modparams} cannot be length 0")

rmses = zeros(kLength, nModels);

["Fitting ", num2str(sum(folds) * nModels), " models"]

for i  = 1:kLength
  
  errs = zeros(1, nModels);
  foldSize = floor(xRows / folds(i));
  
  rowIdx = 1:(folds(i) * foldSize);
  
  for j = 1:folds(i)
    
    indexBits = rowIdx > ((j - 1) * foldSize) & rowIdx <= (j * foldSize);
    rowsTrain = rowIdx(!indexBits);
    rowsTest  = rowIdx(indexBits);  
    
    xTrain = x(rowsTrain, :);
    yTrain = y(rowsTrain);
    xTest  = x(rowsTest, :);
    yTest  = y(rowsTest);
    
    for k = 1:nModels
      
      model = feval(modfit, xTrain, yTrain, modparams(k));
      yHat = feval(modpre, model, xTest);
      
      errs(1, k) = errs(1, k) + mean((yTest - yHat).^2).^(1/2) / folds(i);
    
    endfor

  endfor
  
  rmses(i, :) = errs';
  
endfor

rmses;

endfunction

%!error crossVal(1, 1:2, @polyfit, @polyval, 1:4, 5)
%!error crossVal(1, 1, @polyfit, @polyval)
%!error crossVal(1, 1:2, @polyfit, @polyval, 1:4)


