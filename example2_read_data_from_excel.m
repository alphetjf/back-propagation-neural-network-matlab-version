% Read Excel file
function [data, indicators, codes] = example2_read_data_from_excel()
    filename = './data/scores.xlsx';  % Replace with your Excel file name
    [num, txt] = xlsread(filename);

    % Extract data matrix - rows:18, cols:12
    [rows, ~] = size(num);
    data = num(1:rows-1, :); 

    % Obtain indicator name
    indicators = txt(1:rows-1, 1);  % The indicator name in the first column
    codes = txt(1:rows-1, 2);           % The indicator name in the second column

    % If necessary, data can be saved to variables
    save('./data/survey_data.mat', 'data', 'indicators', 'codes');

    % Display basic information of data
    disp('In example2_read_data_from_excel')
    disp('data dimension：');
    disp(size(data));
end