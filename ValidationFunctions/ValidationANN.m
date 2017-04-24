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

for i = 1:4:length(validationData)-96
    colonn = 1;
    for j = i:4:i+92
        [input tmpTarget(row, colonn)] = HourlyInputTarget( validationData,j+4, i );
        colonn = colonn + 1;
        [~, ~, output(row,colonn-1)] = calcOutput( input, inputWeights, hiddenWeights ); 
    end
    row = row + 1;
end

good = 0;
bad = 0;

for i = 1:length(tmpTarget)
    if abs(output(i,5) - tmpTarget(i,5)) < 0.2517
        good = good+1;
    else
        bad = bad+1;
        
    end
end

% graphs(output, tmpTarget, dateAndTime);

end