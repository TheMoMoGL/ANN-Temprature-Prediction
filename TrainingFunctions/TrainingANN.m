function [inputWeights, hiddenWeights, outputWeights, error] = TrainingANN(trainingData, numInput, numHidden, numHiddLay, n, trainingTarget, time)

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
%          error -> Error between our forecast and 'trainingTarget'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

total = length(trainingData);
time = time * 4;

% Generate weights
[inputWeights, hiddenWeights, outputWeights] = WeightsGenerator(numInput, numHidden, numHiddLay);

% Training counter
trainCount = 1;

% Training
good = 0;
% This loop runs untilthe percentage of correct predictions are greater
% than the percent value in the while statement
while(good/total) < 0.6 

    good = 0;
    for i = 1:4:length(trainingData) - time
        % Create function that selects the right inputs among the training data
        [input, target(i)] = HourlyInputTarget(trainingData, i+time, i, trainingTarget);
        [newInput, hiddenOutput, output(i)] = calcOutput(input, inputWeights, hiddenWeights, outputWeights, numHiddLay); % Prediction
        if abs(output(i) - target(i)) > 1 % if error is less than this value BP is not preformed
            % Back propagation
            [inputWeights,outputWeights, hiddenWeights] = BackP(output(i), target(i), outputWeights, inputWeights, hiddenOutput, newInput,n,hiddenWeights,numHiddLay);
        end
        error(trainCount) = abs(output(i) - target(i));
        trainCount = trainCount +1;
    end
    % Calculates the number of correct predictions
    for i = 1:length(target)
        if abs(output(i) - target(i)) < 2
            good = good + 1;
        end
    end 
end
end