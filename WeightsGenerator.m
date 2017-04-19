function [ inputWeights, hiddenWeights ] = WeightsGenerator( numInput, numHidden )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%input: numInput -> number of input nodes
%       numHidden -> number of hidden nodes
%output: inputWeights -> a numInput x numHidden matrix with random weights
%        hiddenWeights -> a numHidden large vector with random weights
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:numInput+1 % +1 because of weight for bias
    for j=1:numHidden
        inputWeights(j, i) = rand;
    end
end
for i=1:numHidden+1 % +1 because of weight for bias
    hiddenWeights(i) = rand;
end
end

