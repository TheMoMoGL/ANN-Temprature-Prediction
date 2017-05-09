function [good, bad, RMSE, MAPE, Corr, output, target] = ValidationANN( validationData, inputWeights, hiddenWeights, outputWeights, trainingTarget, numHiddLay, time)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: validationData -> Validation data vector
%         inputWeights -> weights between input and hidden layer
%         hiddenWeights -> weights between hidden and output layer
%
% Outputs: good -> Accurate temperature forecasts
%          bad -> Non-accurate temperature forecasts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

time = time * 4;
row = 1;

for i = 1:4:length(validationData)-(96+time)
    column = 1;
    for j = i:4:i+92  %(96-time)
        [input, target(row, column)] = HourlyInputTarget( validationData,j+time, i,trainingTarget );
        column = column + 1;
        [~, ~, output(row,column-1)] = calcOutput( input, inputWeights, hiddenWeights, outputWeights, numHiddLay); 
    end
    row = row + 1;
end

% Validation of last 24 hours
for i = length(validationData)-(92+time) : 4 : length(validationData)
    column = 1;
     for j = i : 4 : length(validationData)-(time+1)
        [input, target(row, column)] = HourlyInputTarget(validationData, j+time, i, trainingTarget);
        column = column + 1;
        [~, ~, output(row,column-1)] = calcOutput(input, inputWeights, hiddenWeights, outputWeights, numHiddLay);
    end
    row = row + 1;
end

% Last value only for time stamp in graph
%output(row-1, :) = output(row-2, :);
%target(row-1, :) = target(row-2, :);
good = 0;
bad = 0;


for i = 1:length(target)

    if abs(output(i,1) - target(i,1)) < 2
        good = good+1;
    else
        bad = bad+1;
        
    end
end
[RMSE, MAPE, Corr] = Error(output, target);

% graphs(output(:,1), target(:,1), dateAndTime, iteration);



end