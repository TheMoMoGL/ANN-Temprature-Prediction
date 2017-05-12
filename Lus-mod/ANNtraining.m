function [inputWeights, hiddenWeights, outputWeights, numHiddLay, good] = ANNtraining(trainingData, numInput, numHidden, numHiddLay, n, trainingTarget, time)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: trainingData -> Training data for the ANN
%         numInput -> Number of nodes in the input layer
%         numHidden -> Number if nodes in the hidden layer
%         numHiddLay -> Number of hidden layers
%         n -> Learning rate
%         trainingTarget -> A vector with the target for each training set
%         time -> How far in to the future the forecast shall predict
% Outputs: inputWeights -> Weights between the input and hidden layer
%          hiddenWeights -> Weights between the first hidden and last hidden layer.
%          outputWeights -> Weights between last hidden layer and output
%          numHiddLay -> Number of hidden layers
%          good -> number of correct predictions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

total = length(trainingData);
time = time * 4;

% Generate weights
[inputWeights, hiddenWeights, outputWeights] = WeightsGenerator(numInput, numHidden, numHiddLay);

% Training
good = 0;
controlledLearning = 1;

while(good/total) < 0.6

    good = 0;
    for i = 1:4:length(trainingData) - time
        [input, target(i)] = HourlyInputTarget(trainingData, i+time, i, trainingTarget);
        [newInput, hiddenOutput, output(i)] = calcOutput(input, inputWeights, hiddenWeights, outputWeights, numHiddLay); % Prediction
        if abs(output(i) - target(i)) > 0  % if error is less than this value BP is not preformed
            % Back propagation
            [inputWeights,outputWeights, hiddenWeights] = BackP(output(i), target(i), outputWeights, inputWeights, hiddenOutput, newInput,n,hiddenWeights,numHiddLay);
            controlledLearning = controlledLearning +1;
        end
    end
    % Calculates the number of correct predictions
    for i = 1:length(target)
        if abs(output(i) - target(i)) < 1
            good = good + 1;
        end
    end 
end
end