function [ newInput, hiddenOutput, output ] = calcOutput( input, inputWeights, hiddenWeights, outputWeights, numHiddLay )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: input -> vector with input values
%         inputWeights -> weights between input and hidden layer
%         hiddenWeights -> weights between hidden and output layer
%
% Outputs: newInput -> input vector with bias
%          hiddenOutput -> hidden output vector with bias
%          output -> predicted output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hiddenSize = size(hiddenWeights);
inputSize = size(inputWeights);
newInput = [1, input]; % Add bias for input layer
if numHiddLay > 1
    hiddenOutput = ones(numHiddLay, hiddenSize(2)); % add bias for all operations
else
    hiddenOutput = ones(1,1);
end

% Calculates and creates the vector with values for the hidden layer
for i = 1:inputSize(1) % 
    hiddenOutput(1,i+1) = ReLu_activation_function(Net(inputWeights(i,:), newInput));
end

if numHiddLay > 1
    hiddenWeightRow = 1;
    for i = 2:numHiddLay % Iterates number of layers
        for j = 2:hiddenSize(2)
            hiddenOutput(i,j) = ReLu_activation_function(Net(hiddenWeights(hiddenWeightRow,:), hiddenOutput(i-1,:)));
            hiddenWeightRow = hiddenWeightRow + 1;
        end
    end
    output = linear_activation(Net(outputWeights, hiddenOutput(numHiddLay,:))); % Predicted output
else
    output = linear_activation(Net(outputWeights, hiddenOutput)); % Predicted output
end    
end