function [good, bad, RMSE, MAPE, Corr, error, output, target] = ValidationANN(validationData, inputWeights, hiddenWeights, outputWeights, trainingTarget, numHiddLay, time)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: validationData -> Validation data vector
%         inputWeights -> weights between input and hidden layer
%         hiddenWeights -> weights between first hidden layer and last
%                          hidden layer.
%         outputWeights -> weights between last hidden and output layer
% Outputs: good -> Accurate temperature forecasts
%          bad -> Non-accurate temperature forecasts
%          RMSE -> Root mean square error
%          MAPE -> Mean average percentage error
%          Corr -> Correlation coefficent
%          error -> Error between output and target
%          output -> Output matrix with our predicted temperature 1-24
%                    hours ahead
%          target -> Matrix with actual temperature.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global validation;
global start;
global Start_month;
global End_month;
time = time * 4;
row = 1;
% Validate for all days except the last 24 hours
% Minus 2 days since the last day is special and the last temp must be 96 rows ahead.
for i = 1:4:length(validationData)-(96+96) 
    column = 1;
    for j = i:4:i+92
        % Separate a input vector and its target from the validationData
        [input, target(row, column)] = HourlyInputTarget(validationData, j+4, i, trainingTarget );
        % Calculates our predicted temperature
        [~, ~, output(row,column)] = calcOutput( input, inputWeights, hiddenWeights, outputWeights, numHiddLay);
        column = column + 1;
    end
    % Calculate the error between our forecast and the actual temperature
    error(row) = abs(output(row) - target(row));
    row = row + 1;
end

% Same as above but for the remaining 24 hours
% Minus 1 day and 23 hours since the last day is special and the last temp must be 96 rows ahead.
for i = length(validationData)-(92+96) : 4 : length(validationData)
    column = 1;
    for j = i : 4 : length(validationData)-(96+1)
        [input, target(row, column)] = HourlyInputTarget(validationData, j+4, i, trainingTarget);
        column = column + 1;
        [~, ~, output(row,column-1)] = calcOutput(input, inputWeights, hiddenWeights, outputWeights, numHiddLay);
    end
    error(row) = abs(output(row) - target(row));
    row = row + 1;
end


% If the start and end month is January, apply averaging method %
progTemp = validation(start:4:length(validation),3);
progEnd = length(output);
progtemp = progTemp(1:progEnd);
if (Start_month == 1 && End_month == 1)
    output(:,1) = (progtemp + output(:,1))/2;
end

% Calculates how many good/bad predictions that were made +/- some limit
good = 0;
bad = 0;
for i = 1:length(target)-(time/4)+1 % its zeros in the end 
    if abs(output(i,(time/4)) - target(i,(time/4))) < 2 % Limit for a good prediction
        good = good+1;
    else
        bad = bad+1;
    end
end

[RMSE, MAPE, Corr] = Error(output(i,(time/4)), target(i,(time/4)));

end