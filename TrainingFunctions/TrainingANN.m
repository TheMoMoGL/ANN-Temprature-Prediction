function [inputWeights, hiddenWeights, outputWeights, good] = TrainingANN(trainingData, numInput, numHidden, numHiddLay, n)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: trainingData -> Training data for the ANN
%         numInput -> Number of nodes in the input layer
%         numHidden -> Number if nodes in the hidden layer
%         n -> Learning rate
% Outputs: inputWeights -> Weights between the input and hidden layer
%          hiddenWeights -> Weights between the hidden and output layer.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Change variable 'time' in the functions TrainingANN & ValidationANN to
% Vary how many hours head the output forecast will predict. 
% !NOTE! They have to match !NOTE!
time = 6;

time = time * 4;

% Generate weights
[inputWeights, hiddenWeights, outputWeights] = WeightsGenerator(numInput, numHidden, numHiddLay);

% Training counter
trainCount = 0;

% Training

for i = 1:4:length(trainingData) - 4
    
    % Create function that selects the right inputs among the training data
    [input, target(i)] = HourlyInputTarget(trainingData, i+time, i);
    [newInput, hiddenOutput, output(i)] = calcOutput(input, inputWeights, hiddenWeights, outputWeights); % Prediction
    
    % Back propagation
    [inputWeights, hiddenWeights] = BackP(output(i), target(i), outputWeights, inputWeights, hiddenOutput, newInput, n);
    trainCount = trainCount + 1;
end

good = 0;
for i = 1:length(target)
    
    if abs(output(i) - target(i)) < 0.0670
        good = good + 1;
        
    end
end

end

