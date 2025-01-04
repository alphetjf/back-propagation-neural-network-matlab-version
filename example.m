% Example usage
cd(fileparts(mfilename('fullpath')));
addpath(genpath(cd));

% 1. Generate sample data
X = linspace(-5, 5, 500)';   %  (n_samples, inputSize)
% 带噪声的正弦函数 sin function with noise
y = sin(X) + 0.1*randn(size(X));  

% 2. 创建和训练网络 Create and train a network
% 1个输入，10个隐藏神经元，1个输出
% 1 input, 10 hidden neurons, 1 output
net = BPNetwork(1, 10, 1);  
[net, loss_history, ~] = train(net, X, y, 1000, 50);

% 3.predict
X_test = linspace(-5, 5, 200)';
y_pred = net.predict(X_test);

% 4.绘制结果
figure;
subplot(2,1,1);
plot(X, y, 'b.', 'DisplayName', 'Training Data');
hold on;
plot(X_test, y_pred, 'r-', 'DisplayName', 'Prediction');
legend;
title('Function Fitting Results');

subplot(2,1,2);
plot(loss_history);
title('Training Loss');
xlabel('Iteration');
ylabel('MSE Loss');

% 5.保存模型 save model
net.save_model('./checkpoint/BPNetwork.mat');

% 6.加载模型参数 load model parameters
net = BPNetwork(1, 10, 1);  
net = net.load_model('./checkpoint/BPNetwork.mat');
