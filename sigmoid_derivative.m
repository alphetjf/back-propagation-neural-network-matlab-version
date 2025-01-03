% 辅助函数：激活函数的一阶导数
% Auxiliary function: the derivative of the activation function
function ds = sigmoid_derivative(x)
    % function 'dsigmoid' is the derivative of function 'sigmoid'
    s = sigmoid(x);
    ds = s .* (1 - s);
end