function [ inputWeights, hiddenWeights ] = TrainingANN( trainingData, numInput, numHidden, n )
%TRAININGANN Summary of this function goes here
%   Detailed explanation goes here

% Normilise
trainingData = Normalisation(trainingData);

% Generate weights
[inputWeights, hiddenWeights] = WeightsGenerator(numInput, numHidden);

% Training
for i=1:length(trainingData)-3
    % create function that selects the right inputs among the training data
    [input, target] = HourlyInputTarget(trainingData,i);
    [ newInput, hiddenOutput, output ] = calcOutput( input, inputWeights, hiddenWeights ); % prediction
    %Back propagation
    [ inputWeights, hiddenWeights ] = BackP( output, target, hiddenWeights, inputWeights, hiddenOutput, newInput,n );
end


end

