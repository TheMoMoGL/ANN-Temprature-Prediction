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
hiddenSize = size(hiddenWeights);
newInput = [1, input]; % Add bias for input layer

% Calculates and creates the vector with values for the hidden layer
for i = 1:hiddenSize(2)-1 % -1 because its 1 less node than number of weights
    hiddenInput(i) = ReLu_activation_function(Net(inputWeights(i,:), newInput));
end

if hiddenSize(1) > 2
    for i = 2:hiddenSize(1) % Iterates number of layers
        hiddenOutput(i-1,:) = [1, hiddenInput]; % Add bias for the hidden layer
        for j = 1:hiddenSize(2)
            hiddenOutput(i,:) = ReLu_activation_function(Net(hiddenWeights(i,:), hiddenOutput(i-1,:)));
        end
    end
    output = linear_activation(Net(hiddenWeights(hiddenSize(1),:), hiddenOutput(hiddenSize(1),:))); % Predicted output
else
    hiddenOutput = [1, hiddenInput];
    output = linear_activation(Net(hiddenWeights, hiddenOutput)); % Predicted output
end    
end