function [good, bad, RMSE, MAPE, Corr, output, target] = ValidationANN( validationData, inputWeights, hiddenWeights, outputWeights)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: validationData -> Validation data vector
%         inputWeights -> weights between input and hidden layer
%         hiddenWeights -> weights between hidden and output layer
%
% Outputs: good -> Accurate temperature forecasts
%          bad -> Non-accurate temperature forecasts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Change variable 'time' in the functions TrainingANN & ValidationANN to
% Vary how many hours head the output forecast will predict.
% !NOTE! They have to match !NOTE!
time = 24;

time = time * 4;
row = 1;
% Validation counter
ValidationCount = 0;



for i = 1:4:length(validationData)-(96+time)
    column = 1;
    for j = i:4:i+92  %(96-time)
        [input, target(row, column)] = HourlyInputTarget( validationData,j+time, i );
        column = column + 1;
        [~, ~, output(row,column-1)] = calcOutput( input, inputWeights, hiddenWeights, outputWeights); 
    end
    row = row + 1;
end

% Validation of last 24 hours
for i = length(validationData)-(92+time) : 4 : length(validationData)
    column = 1;
     for j = i : 4 : length(validationData)-(time+1)
        [input, target(row, column)] = HourlyInputTarget(validationData, j+time, i);
        column = column + 1;
        [~, ~, output(row,column-1)] = calcOutput(input, inputWeights, hiddenWeights, outputWeights);
    end
    row = row + 1;
end

% Last value only for time stamp in graph
%output(row-1, :) = output(row-2, :);
%target(row-1, :) = target(row-2, :);
good = 0;
bad = 0;


for i = 1:length(target)

    if abs(output(i,1) - target(i,1)) < 0.0618
        good = good+1;
    else
        bad = bad+1;
        
    end
end
[RMSE, MAPE, Corr] = Error(output, target);

% graphs(output(:,1), target(:,1), dateAndTime, iteration);


end