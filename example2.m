%------------------------------- Statement -------------------------------
%《assessing the aging suitability evaluation system of rural 
%  living environment》
clear, clc
rng(1);
cd(fileparts(mfilename('fullpath')));
addpath(genpath(cd));
%========== 1.Read Excel file ==========
%  obtain variables: data, indicators, codes
[data, indicators, codes] = example2_read_data_from_excel();

%========== 2.Preprocess ==========
[X, n_samples, inputSize] = example2_preprocess(data);
% X: (n_samples, inputSize)

% Obtain the objective values of data -> get Y
[Y, outputSize] = example2_calc_objective(X);
% Y: (n_samples, outputSize)

% Shuffle data, and separate data into the training and validating 
%   in 80% and 20% respectively.
idx = randperm(n_samples);
traininig_rate=0.8; validating_rate=1-traininig_rate;
trainSize=floor(traininig_rate*n_samples); 
validateSize=n_samples-trainSize;

X_shuffled=X(idx,:); Y_shuffled=Y(idx,:);
X_train=X_shuffled(1:trainSize,:); Y_train=Y_shuffled(1:trainSize,:);
X_validate=X_shuffled(trainSize+1:n_samples,:); 
Y_validate=Y_shuffled(trainSize+1:n_samples,:);

%========== 3.Create and train a network ==========
% 18 input, 10 hidden neurons, 1 output
% 1000 epochs, 4 the batch size
net = BPNetwork(inputSize, 10, outputSize);  
[net, train_loss_history, validate_loss_history] = train(net, X, Y, 1000, 4, X_validate, Y_validate);

figure
plot(train_loss_history, 'b-', 'LineWidth', 2, 'DisplayName', 'Training Loss');
hold on;
plot(validate_loss_history, 'r--', 'LineWidth', 2, 'DisplayName', 'Validation Loss');
title('Training Performance');
xlabel('Iteration');
ylabel('Loss');
legend('show');
grid on;
set(gca, 'FontSize', 12);
set(gcf, 'Position', [100, 100, 800, 600]);

box on;
set(gca, 'LineWidth', 1.5);  % Set the width of the coordinate axis line
set(gcf, 'Color', 'white');  % Set the background to white

%========== 4.validate ==========
Y_pred = net.predict(X_validate);
% validate_error = mean(sum((Y_pred - Y_validate).^2, 1));
validate_error = mean(abs(Y_pred - Y_validate)./Y_pred);
disp('The validation error:');
disp(validate_error);