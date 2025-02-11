% BP Neural Network for Regression
classdef BPNetwork
    properties
        W1          % 输入层到隐藏层的权重 - (hiddenSize, inputSize)
        b1          % 隐藏层偏置           - (hiddenSize, 1)
        W2          % 隐藏层到输出层的权重 - (outputSize, hiddenSize)
        b2          % 输出层偏置           - (outputSize, 1)
        learning_rate   % 学习率
        batch_size
        input_scale    % 输入数据归一化参数
        output_scale   % 输出数据归一化参数
    end
    
    methods
        % 网络参数设置 Network parameter settings
        function net = BPNetwork(inputSize, hiddenSize, outputSize)
            % 随机初始化权重和偏置 Randomly initialize weights and biases
            net.W1 = randn(hiddenSize, inputSize) * sqrt(2/inputSize);
            net.b1 = zeros(hiddenSize, 1);
            net.W2 = randn(outputSize, hiddenSize) * sqrt(2/hiddenSize);
            net.b2 = zeros(outputSize, 1);
            % 学习参数 learning parameters
            net.learning_rate = 0.1;
        end
        
        % 前向传播 forward propagation
        function [output, cache] = forward(net, X)
            % 隐藏层 Hidden layer
            % X - (batchSize, inputSize)
            z1 = X * net.W1' + net.b1';  
            a1 = sigmoid(z1);  % sigmoid activation
            % z1, a1-(batchSize, hiddenSize)
            
            % 输出层 Output layer
            z2 = a1 * net.W2' + net.b2';
            output = z2;   % Linear activation for regression
            % z2    - (batchSize，outputSiz)
            % output-(batchSize，outputSize)
            
            % 保存中间值用于反向传播 Save intermediate values for backpropagation
            cache.X = X;
            cache.z1 = z1;  % -(batchSize, hiddenSize)
            cache.a1 = a1;  % -(batchSize, hiddenSize)
            cache.z2 = z2;  % -(batchSize，outputSize)
        end
        
        % 反向传播 Back Propagation
        function [gradients] = backward(net, cache, y, output)
            % y - (batchSize, outputSize)
            m = size(y, 1);
            
            % 输出层误差 Output layer error
            % theta2 - (batchSize, outputSize)
            theta2 = - (y - output) .* sigmoid_derivative(cache.z2);
            dW2 = (1/m) * (theta2' * cache.a1);
            db2 = (1/m) * sum(theta2, 1);
            
            % 隐藏层误差 Hidden layer error
            % theta1 - (batchSize, hiddenSize)
            theta1 = (theta2 * net.W2) .* sigmoid_derivative(cache.z1);
            dW1 = (1/m) * (theta1' * cache.X);
            db1 = (1/m) * sum(theta1, 1);
            
             % 保存梯度 Save gradient
            gradients.dW1 = dW1;    % - (hiddenSize, inputSize)
            gradients.db1 = db1';   % - (hiddenSize, 1)
            gradients.dW2 = dW2;    % - (outputSize, hiddenSize)
            gradients.db2 = db2;    % - (outputSize, 1)
        end
        
        % 更新参数
        function net = update_params(net, gradients)
            net.W1 = net.W1 - net.learning_rate * gradients.dW1;
            net.b1 = net.b1 - net.learning_rate * gradients.db1;
            net.W2 = net.W2 - net.learning_rate * gradients.dW2;
            net.b2 = net.b2 - net.learning_rate * gradients.db2;
        end
        
        % 训练函数 Training
        function [net, loss_history, validate_loss] = train(net, X, y, epochs, batch_size, varargin)
            if ~isempty(varargin)
                X_validate = varargin{1};
                y_validate = varargin{2};
            end
            % X - (n_sample, inputSize)
            % Y - (n_sample, outputSize)
            
            n_samples = size(X, 1);
            n_batches = floor(n_samples/batch_size);
            loss_history = zeros(epochs * n_batches, 1);
            counter = 1;
            validate_loss= zeros(epochs * n_batches, 1);
            
            for epoch = 1:epochs
                % Randomly shuffle data
                idx = randperm(n_samples);
                X_shuffled = X(idx, :);
                Y_shuffled = y(idx, :);
                
                for batch = 1:n_batches
                    % Extract batch data
                    start_idx = (batch-1)*batch_size + 1;
                    end_idx = min(batch*batch_size, n_samples);
                    X_batch = X_shuffled(start_idx:end_idx, :);
                    Y_batch = Y_shuffled(start_idx:end_idx, :);
                    
                    % 前向传播 forward propagation
                    [output, cache] = net.forward(X_batch);

                    % 计算训练损失 Calculate training losses
                    % loss = mean(sum((output - Y_batch).^2, 1)); % MSE
                    loss = mean(abs(output - Y_batch)./output);
                    loss_history(counter) = loss;
                    
                    % 计算验证损失 Calculate validation losses]
                    if nargin > 5
                        [y_pred, ~] = net.forward(X_validate);
                        % vloss = mean(sum((y_pred - y_validate).^2, 1)); % MSE
                        vloss = mean(abs(y_pred - y_validate)./y_pred);
                        validate_loss(counter) = vloss;
                    end

                    % 反向传播 Back Propagation
                    gradients = net.backward(cache, Y_batch, output);

                    % 更新参数 Update Parameters
                    net = net.update_params(gradients);

                   if mod(counter, 100) == 0
                       fprintf('Epoch %d, Batch %d/%d, Loss: %.4f\n', ...
                           epoch, batch, n_batches, loss);
                   end
                   counter = counter + 1;
                end
            end
        end
        
        % 预测函数 Prediction
        function y_pred = predict(net, X)
            [y_pred, ~] = net.forward(X);
        end

        function save_model(net, filename)
            % 保存模型参数
            model_params = struct();
            model_params.W1 = net.W1;
            model_params.b1 = net.b1;
            model_params.W2 = net.W2;
            model_params.b2 = net.b2;
            model_params.learning_rate = net.learning_rate;
            save(filename, 'model_params');
        end
        
        function net = load_model(net, filename)
            % 加载模型参数
            load(filename);
            net.W1 = model_params.W1;
            net.b1 = model_params.b1;
            net.W2 = model_params.W2;
            net.b2 = model_params.b2;
            net.learning_rate = model_params.learning_rate;
        end
    end
end
