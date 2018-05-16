function [ rmse ] = crossVal( x, y, modfit, modpre, modparams, folds )
% Prototype: crossVal( x, y, modfit, modpre, modparams, folds)
%
% Cross-Validate a parameterizable model for any number of folds.
% This works for any type of model fitting function. (Only tested for polyval)
% Depending on how your model consumnes function parameters you might have to
% adjust the parameter passing.
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
% @param {folds}     matrix (k x 1) of integers 
%
% [ out ]
% 
% @return {rmse}     matrix (length({folds}) x length({modparams})) 
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

rmse = zeros(kLength, nModels);

% Fancy Status Message
["Fitting ", num2str(sum(folds) * nModels), " models"]

for i  = 1:kLength
  
  % Compute number of observations in a fold. We round down, so we discard up to
  % k-1 observations
  kRMSE = zeros(1, nModels);
  foldSize = floor(xRows / folds(i));
  
  rowIdx = 1:(folds(i) * foldSize);
  
  for j = 1:folds(i)
    
    % Use a little bit of black magic to compute indices
    indexBits = rowIdx > ((j - 1) * foldSize) & rowIdx <= (j * foldSize);
    rowsTrain = rowIdx(!indexBits);
    rowsTest  = rowIdx(indexBits);  
    
    % assign testset and training set
    xTrain = x(rowsTrain, :);
    yTrain = y(rowsTrain);
    xTest  = x(rowsTest, :);
    yTest  = y(rowsTest);
    
    for k = 1:nModels
      
      % fit and evaluate model
      model = feval(modfit, xTrain, yTrain, modparams(k));
      yHat = feval(modpre, model, xTest);
      
      % compute root means squared error
      kRMSE(1, k) = kRMSE(1, k) + mean((yTest - yHat).^2).^(1/2) / folds(i);
    
    endfor

  endfor
  
  rmse(i, :) = kRMSE';
  
endfor

rmse;

endfunction

%!error crossVal(1, 1:2, @polyfit, @polyval, 1:4, 5)
%!error crossVal(1, 1, @polyfit, @polyval)
%!error crossVal(1, 1:2, @polyfit, @polyval, 1:4)


