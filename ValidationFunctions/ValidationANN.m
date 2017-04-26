function [good, bad, RMSE, MAPE, Corr] = ValidationANN( validationData, inputWeights, hiddenWeights, iteration)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: validationData -> Validation data vector
%         inputWeights -> weights between input and hidden layer
%         hiddenWeights -> weights between hidden and output layer
%
% Outputs: good -> Accurate temperature forecasts
%          bad -> Non-accurate temperature forecasts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

row = 1;
% Validation counter
ValidationCount = 0;

dateAndTime = loadVariable('Date_Time_validation.mat');


for i = 1:4:length(validationData)-96
    column = 1;
    for j = i:4:i+92
        [input, target(row, column)] = HourlyInputTarget( validationData,j+4, i );
        column = column + 1;
        [~, ~, output(row,column-1)] = calcOutput( input, inputWeights, hiddenWeights );
        
    end
    ValidationCount = ValidationCount+1;
    row = row + 1;
end

% Validation of last 24 hours
for i = length(validationData)-95 : 4 : length(validationData)
    column = 1;
    for j = i : 4 : length(validationData)-4
        [input, target(row, column)] = HourlyInputTarget(validationData, j+4, i);
        column = column + 1;
        [~, ~, output(row,column-1)] = calcOutput(input, inputWeights, hiddenWeights );
    end
    row = row + 1;
end

% Last value only for time stamp in graph
output(row-1, :) = output(row-2, :);
target(row-1, :) = target(row-2, :);
good = 0;
bad = 0;


for i = 1:length(target)
%    if abs(output(i,24) - target(i,24)) < 2
    if abs(output(i,24) - target(i,24)) < 0.0616
        good = good+1;
    else
        bad = bad+1;
        
    end
end

[RMSE, MAPE, Corr] = Error(output, target);

%graphs(output(:,1), target(:,1), dateAndTime, iteration);

end