function [data_norm, n_samples, inputSize] = example2_preprocess(data)
    data = data';
    [n_samples,inputSize] = size(data);
    % normalize data
    col_sums = sum(data, 1);  % 1: Calculate the sum of each column
    % Normalize using matrix operations
%     data_norm = data ./ col_sums;
    data_norm = data;
end