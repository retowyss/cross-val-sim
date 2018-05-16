# Cross Validation Simulator

This small collection of functions evaluates models with respective to their
cross-validation RMSE. Any type of model fitting function may be evaluated.

# Getting Started

Instepct and run `main.m` to see this in action.

# Findings

No rigorous experiments were completed. However, we can make two anecdotal 
observations.
First, models with the true number of parameters almost always fit best. 
Second, there is cross over in RMSE between models. This means that what we 
use to assess the performance of a model is a function of the evaluation 
parameter k (the number of folds).

# Compatibility

This was developed on Octave and no tests were run for Matlab.
