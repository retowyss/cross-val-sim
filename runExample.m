% This script runs a cross validation simulation
% This comes with three functions: generateData, crossVal and plotSim

SAMPLE_SIZE = 2000;
DEGREE = 4;
MODEL_PARAMETERS = 3:7;
FOLDS = [2:10, 20, 30];

% Create a random polynomial of degree DEGREE
polynomial = (rand(DEGREE + 1, 1) - 0.5);

% Generate Dataset
[y, x] = generateData(polynomial, SAMPLE_SIZE);

% Generate noise
y = y + (rand(SAMPLE_SIZE, 1) - .5) * ((max(y) - min(y)) / 5);

% Run simulation
rmse = crossVal(x, y, @polyfit, @polyval, MODEL_PARAMETERS, FOLDS);

% Print simulation
rmse

% Draw Plot
plotSim(rmse, MODEL_PARAMETERS, FOLDS)