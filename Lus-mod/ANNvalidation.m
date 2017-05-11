function [good, bad, RMSE, MAPE, Corr, error, output, target] = ANNvalidation( A, time)

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

for ANNcount = 1 : length(A)
    good = 0;
    for i = 1:4:length(A{1,ANNcount}.Data)-time
        [input, target(row)] = HourlyInputTarget( A{1,ANNcount}.Data, i+time, i,A{1,ANNcount}.Data(:,4) );    
        output(row) = ReasoningOutput( input, A );
        error(row) = abs(output(row) - target(row));
        if error(row) < 2
            good = good+1;
        end
        row = row + 1;
    end
  good  
end
 
% Validation of last 24 hours
% for i = length(validationData)-(92+time) : 4 : length(validationData)
%     column = 1;
%     for j = i : 4 : length(validationData)-(time+1)
%        [input, target(row, column)] = HourlyInputTarget(validationData, j+time, i, trainingTarget);
%        column = column + 1;
%        [~, ~, output(row,column-1)] = calcOutput(input, inputWeights, hiddenWeights, outputWeights, numHiddLay);
%     end
%     error(row) = abs(output(row) - target(row));
%     row = row + 1;
% end

good = 0;
bad = 0;
for i = 1:length(target)

    if abs(output(i) - target(i)) < 2
        good = good+1;
    else
        bad = bad+1;     
    end
end
[RMSE, MAPE, Corr] = Error(output, target);



end