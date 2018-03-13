function success = plotSim(rmses, modparams, folds)

plot (rmses)

ylabel ("RMSE");
ylabel ("Folds (k)");

legend (arrayfun(@(x) {strcat('Model \t', num2str(x))}, modparams))

title ('Cross Validation Simulation')

%set(gca, 'xticklabelmode', 'manual') 
%set(gca, 'xticklabel', folds) 

endfunction