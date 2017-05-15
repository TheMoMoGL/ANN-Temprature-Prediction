function [ output ] = ReasoningOutput( input, A )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: input -> Input vector with data to base forecast on
%         A -> A struct array with ANN data from training
% Outputs: output -> Forecast temperature
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

outputIndex = 1;
outputVector = 0;
index = 0;
rmse = 1000;
% Steps through all ANNs to find as many forecasts to base prediction on
for i = 1 : length(A)
    % If SMHI forecast > Max AND SMHI forecast < Min for the data set its
    % appropriate to make a forecast
    if (A{1,i}.Max(3) > input(3)) && (A{1,i}.Min(3) < input(3))
        % Normalisation on the input based on the settings from the month
        % the ANN is trained from.
        normInput1 = Normalisation(input, A{1,i}.Max, A{1,i}.Min);
        % Forecast the temperature
        [~, ~, outputVector(outputIndex)] = calcOutput(normInput1 , A{1,i}.Input, A{1,i}.Hidden, A{1,i}.Output, A{1,i}.Layers);
        % Validate based on RMSE
        RMSE = sqrt( sum( ( input(3) - outputVector(outputIndex) ).^2 ) ./ numel(outputVector(outputIndex)) ); 
        %[~, RMSE, ~] = Error(outputVector(outputIndex) , input(3) );
        % Checks if the RMSE is better the any previous forecast,
        % if so the index to that value in the outputVector is saved
        if RMSE < rmse
            index = outputIndex;
            rmse = RMSE;
        end
        outputIndex = outputIndex +1;
    end
end
% If the RMSE value is off the prediction is the mean value of all outputs
% else the temperature with the best RMSE is selected as the output
if index == 0 || index > length(outputVector)
    output = sum(outputVector)/length(outputVector);
else
    output = outputVector(index);
end
end

