function [good, bad] = ValidationANN( validationData, inputWeights, hiddenWeights ) 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: validationData -> Validation data vector
%         inputWeights -> weights between input and hidden layer
%         hiddenWeights -> weights between hidden and output layer
%
% Outputs: good -> Accurate temperature forecasts
%          bad -> Non-accurate temperature forecasts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

validationData = Normalisation(validationData);
row = 1;
% Validation counter
ValidationCount=0;

dateAndTime = loadVariable('Date_Time_validation.mat');


for i = 1:4:length(validationData)-96
    column = 1;
    for j = i:4:i+92

        [input, Target(row, column)] = HourlyInputTarget( validationData,j+4, i );
        column = column + 1;
        [~, ~, output(row,column-1)] = calcOutput( input, inputWeights, hiddenWeights ); 

    end
    ValidationCount=ValidationCount+1;
    row = row + 1;
end

good = 0;
bad = 0;

for i = 1:length(Target)
    if abs(output(i,5) - Target(i,5)) < 0.2517
        good = good+1;
    else
        bad = bad+1;
        
    end
end


Message = 'ANN Succesfully validated with';   
confirmationMessage = sprintf('%s %d examples.',Message,ValidationCount);
disp(confirmationMessage)
Statistics=sprintf('Temprature difference < 2 degrees Celsius:%d (Good predictions) \nTemprature difference > 2 degrees Celsius:%d (Bad predictions)',good,bad);
disp(Statistics)

% graphs(output, tmpTarget, dateAndTime);

end