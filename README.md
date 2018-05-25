# Cross Validation Simulator

This small collection of functions evaluates models with respect to their
cross-validation RMSE. Any type of model fitting function may be evaluated.

![Preview](/cross-val-sim.png?raw=true)


# Getting Started

Instepct and run `main.m` to see this in action.

# Findings

No rigorous experiments were completed. However, we can make two 
observations.
First, models with the true number of parameters almost always fit best. 
Second, there is cross over in RMSE between models. This means that what we 
use to assess the performance of a model is a function of the evaluation 
parameter k (the number of folds).

# Compatibility

This was developed on GNU Octave (version 4.0.0) and no tests were run for 
Matlab.
