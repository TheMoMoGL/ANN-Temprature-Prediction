function [ newInput, hiddenOutput, output ] = calcOutput( input, inputWeights, hiddenWeights )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: input -> vector with input values
%         inputWeights -> weights between input and hidden layer
%         hiddenWeights -> weights between hidden and output layer
%
% Outputs: newInput -> input vector with bias
%          hiddenInput -> hidden input vector after sigmoid calculation
%          hiddenOutput -> hidden output vector with bias
%          output -> predicted output
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
weightSize = size(hiddenWeights);

newInput = [1, input]; % Add bias for input layer
hiddenInput = zeros(1, length(hiddenWeights)-1);

% Calculates and creates the vector with values for the hidden layer
for i = 1:length(hiddenWeights)-1 % -1 because its 1 less node than number of weights
     hiddenInput(i) = ReLu_activation_function(Net(inputWeights(i,:), newInput));
end

if weightSize(1) > 1 % if there's more than 1 hidden layer it can access the nested loop
    for i = 1:weightSize(1) % iterates number of layers
        hiddenOutput = [1, hiddenInput]; % add bias for hidden input
        for j = 1:weightSize(2)-1 % -1 because its 1 less node than number of weights
            hiddenOutput = ReLu_activation_function(Net(hiddenWeights(i,:), newInput));
        end
    end
    output = linear_activation(Net(hiddenWeights, hiddenOutput)); % Predicted output
else
    hiddenOutput = [1, hiddenInput]; % Add bias for the hidden layer
    output = linear_activation(Net(hiddenWeights, hiddenOutput)); % Predicted output
end
end