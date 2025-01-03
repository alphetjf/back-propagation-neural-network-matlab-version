% 辅助函数：激活函数
% Auxiliary function: activation function
function s = sigmoid(x)
    % function 'sigmoid'
    s = 1 ./ (1 + exp(-x));
end

