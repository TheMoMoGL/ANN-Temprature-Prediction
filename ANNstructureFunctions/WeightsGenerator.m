function [ inputWeights, hiddenWeights, outputWeights ] = WeightsGenerator( numInput, numHidden, numHiddenLayers )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%input: numInput -> Number of input nodes
%       numHidden -> Number of hidden nodes
%       numHiddenLayers -> Number of hidden layers
%output: inputWeights -> a numInput x numHidden matrix with random weights
%        hiddenWeights -> a numHidden large vector/matrix with random weights
%        outputWeights -> a numHidden large vector with random weights
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Weights between input and first hidden
for i = 1:numInput+1 % +1 because of weight for bias
    for j = 1:numHidden
        inputWeights(j, i) = rand;
    end
end

% Weights between all hidden layers, only included if more than 1 hidden layer
hiddenWeights = 0;
if numHiddenLayers > 1
    for i = 1:(numHiddenLayers-1)*numHidden % +1 because of output layer weights
        for j = 1:(numHidden)+1 % +1 because of weight for bias
            hiddenWeights(i, j) = rand;
        end
    end
end

% Weights between last hidden layer and output
for i = 1:(numHidden)+1 % +1 because of weight for bias
    
    outputWeights(1, i) = rand;
end
end