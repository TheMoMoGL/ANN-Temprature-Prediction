function [inputWeights, hiddenWeights, outputWeights, error] = TrainingANN(trainingData, numInput, numHidden, numHiddLay, n, trainingTarget, time)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: trainingData -> Training data for the ANN
%         numInput -> Number of nodes in the input layer
%         numHidden -> Number if nodes in the hidden layer
%         n -> Learning rate
% Outputs: inputWeights -> Weights between the input and hidden layer
%          hiddenWeights -> Weights between the hidden and output layer.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

total = length(trainingData);
time = time * 4;

% Generate weights
[inputWeights, hiddenWeights, outputWeights] = WeightsGenerator(numInput, numHidden, numHiddLay);

% Training counter
trainCount = 1;

% Training
good = 0;
controlledLearning = 1;

while(good/total) < 0.6
    good = 0;
    for i = 1:4:length(trainingData) - time
        % Create function that selects the right inputs among the training data
        [input, target(i)] = HourlyInputTarget(trainingData, i+time, i, trainingTarget);
        [newInput, hiddenOutput, output(i)] = calcOutput2(input, inputWeights, hiddenWeights, outputWeights, numHiddLay); % Prediction
        if abs(output(i) - target(i)) > 2
            % Back propagation
            [inputWeights,outputWeights, hiddenWeights] = BackP(output(i), target(i), outputWeights, inputWeights, hiddenOutput, newInput,n,hiddenWeights,numHiddLay);
            controlledLearning = controlledLearning +1;
        end
        error(trainCount) = abs(output(i) - target(i));
        trainCount = trainCount +1;
    end
    controlledLearning 
    trainCount
    for i = 1:length(target)
        if abs(output(i) - target(i)) < 2
            good = good + 1;
        end
    end 
end
end