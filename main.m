% This script runs a cross validation simulation

% Example Constants
% Size of the sample (number of x and y columns)
SAMPLE_SIZE = 2000;     
% Degree of Generator
DEGREE = 4;
% Degrees of fitted polynomials             
MODEL_PARAMETERS = 3:7;
% Number k of folds (leave one out: SAMPLE_SIZE - 1) 
FOLDS = [2:10, 20, 30]; 
% Don't make this much larger
NOISE = 0.2;            

% Create a random polynomial
polynomial = (rand(DEGREE + 1, 1) - 0.5);

% Generate dataset
[y, x] = generateData(polynomial, SAMPLE_SIZE);

% Generate noise
y = y + (rand(SAMPLE_SIZE, 1) - 0.5) * ((max(y) - min(y)) * NOISE);

% Run simulation
% we fit a polynoial model to the data
rmse = crossVal(x, y, @polyfit, @polyval, MODEL_PARAMETERS, FOLDS);

% Print rmse
rmse

% Draw plot
plotSim(rmse, MODEL_PARAMETERS, FOLDS)
