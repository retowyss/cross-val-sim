sampleSize = 2000;
degree = 4;
polynomial = (rand(degree + 1, 1) - 0.5);
modparams = 3:5
folds = [2:30]

[y, x] = dataGen(polynomial, sampleSize);
y = y + (rand(sampleSize, 1) - .5) * ((max(y) - min(y)) / 5);

%rmse = crossVal(x, y, @polyfit, @polyval, 3:7, [2, 10, sampleSize / 2, sampleSize]);

rmse = crossVal(x, y, @polyfit, @polyval, modparams, folds);

rmse

plotSim(rmse, modparams, folds)