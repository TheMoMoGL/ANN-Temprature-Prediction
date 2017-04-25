function [good, bad, RMSE, MAPE, Corr] = ValidationANN( validationData, inputWeights, hiddenWeights, maxValues, minValues)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: validationData -> Validation data vector
%         inputWeights -> weights between input and hidden layer
%         hiddenWeights -> weights between hidden and output layer
%
% Outputs: good -> Accurate temperature forecasts
%          bad -> Non-accurate temperature forecasts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%validationData = Normalisation(validationData);
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

% validation of last 24-hours
for i = length(validationData)-95 : 4 : length(validationData)
    column = 1;
    for j = i : 4 : length(validationData)-4
        [input, target(row, column)] = HourlyInputTarget(validationData, j+4, i);
        column = column + 1;
        [~, ~, output(row,column-1)] = calcOutput(input, inputWeights, hiddenWeights);
    end
    row = row + 1;
end

% last value only for time stamp in graph
output(row-1, :) = output(row-2, :);
target(row-1, :) = target(row-2, :);
good = 0;
bad = 0;

% [~, column] = size(target);

% for iteration = 1:column
%     target(:,iteration) = Reverse_normalisation(target(:,iteration), maxValues(4), minValues(4));
%     output(:,iteration) = Reverse_normalisation(output(:,iteration), maxValues(4), minValues(4));
% end


for i = 1:length(target)
%    if abs(output(i,24) - target(i,24)) < 2
    if abs(output(i,24) - target(i,24)) < 0.0616
        good = good+1;
    else
        bad = bad+1;
        
    end
end

[RMSE, MAPE, Corr] = Error(output, target);

% Message = 'ANN Succesfully validated with';
% confirmationMessage = sprintf('%s %d examples.',Message,ValidationCount);
% disp(confirmationMessage)
% Statistics=sprintf('Temprature difference < 2 degrees Celsius:%d (Good predictions) \nTemprature difference > 2 degrees Celsius:%d (Bad predictions)',good,bad);
% disp(Statistics)

<<<<<<< HEAD
 graphs(output(:,1), target(:,1), dateAndTime);

=======
%graphs(output(:,1), target(:,1), dateAndTime);
>>>>>>> refs/remotes/origin/master

end