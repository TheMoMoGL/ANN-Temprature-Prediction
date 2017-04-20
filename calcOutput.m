function [ newInput, hiddenInput, hiddenOutput, output ] = calcOutput( input, inputWeights, hiddenWeights )

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

newInput = [1, input]; % Add bias for input layer

% Calculates and creates the vector with values for the hidden layer
for i=1:length(hiddenWeights)-1 % -1 because its 1 less node than number of weights
     hiddenInput(i) = sigmoid(Net(inputWeights(:,i), newInput));
end

hiddenOutput = [1, hiddenInput]; % Add bias for the hidden layer

output = sigmoid(Net(hiddenWeights, hiddenOutput)); % Predicted output

end

