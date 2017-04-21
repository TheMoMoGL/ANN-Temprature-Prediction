function [ inputWeights, hiddenWeights ] = TrainingANN( trainingData, numInput, numHidden, n )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: trainingData -> Training data for the ANN
%         numInput -> Number of nodes in the input layer
%         numHidden -> Number if nodes in the hidden layer
%         n -> Learning rate
% Outputs: inputWeights -> Weights between the input and hidden layer
%          hiddenWeights -> Weights between the hidden and output layer.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normilise
trainingData = Normalisation(trainingData);

% Generate weights
[inputWeights, hiddenWeights] = WeightsGenerator(numInput, numHidden);

% Training
for i=1:4:length(trainingData)-4
    % create function that selects the right inputs among the training data
    [input, target] = HourlyInputTarget(trainingData, i+4, i);
    [ newInput, hiddenOutput, output ] = calcOutput( input, inputWeights, hiddenWeights ); % prediction
    %Back propagation
    [ inputWeights, hiddenWeights ] = BackP( output, target, hiddenWeights, inputWeights, hiddenOutput, newInput,n );
end


end

