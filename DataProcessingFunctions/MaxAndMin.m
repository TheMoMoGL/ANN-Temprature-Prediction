function [normalisedValidation, normalisedTraining, maxValues, minValues] = MaxAndMin(validationData, trainingData)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: validationData -> Validation data vector
%         inputWeights -> weights between input and hidden layer
%         hiddenWeights -> weights between hidden and output layer
%
% Outputs: good -> Accurate temperature forecasts
%          bad -> Non-accurate temperature forecasts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

totalData = [validationData; trainingData];
maxValues = max(totalData);
minValues = min(totalData);

normalisedValidation = Normalisation(validationData, maxValues, minValues);
normalisedTraining = Normalisation(trainingData, maxValues, minValues);

end