function [Y, outputSize] = example2_calc_objective(X)
    % ANP weights
    W = [0.081 0.116 0.046 0.055 0.119 0.095 0.088 0.096...
        0.092 0.006 0.019 0.010 0.007 0.078 0.044 0.022 0.004 0.020]';
    Y = X*W;
    outputSize = size(Y, 2);
end