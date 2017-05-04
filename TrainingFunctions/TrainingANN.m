function [inputWeights, hiddenWeights, outputWeights] = TrainingANN( trainingData, numInput, numHidden, numHiddLay, n )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: trainingData -> Training data for the ANN
%         numInput -> Number of nodes in the input layer
%         numHidden -> Number if nodes in the hidden layer
%         n -> Learning rate
% Outputs: inputWeights -> Weights between the input and hidden layer
%          hiddenWeights -> Weights between the hidden and output layer.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Normilise
%[trainingData] = Normalisation(trainingData, maxValues, minValues);

% Change variable 'time' in the functions TrainingANN & ValidationANN to
% Vary how many hours head the output forecast will predict. 
% !NOTE! They have to match !NOTE!
time = 6;

time = time * 4;

% Generate weights
[inputWeights, hiddenWeights, outputWeights] = WeightsGenerator(numInput, numHidden, numHiddLay);

%Training counter
trainCount=0;
% Training
for p = 1 : 3 
    for i=1:4:length(trainingData)-time % trains to forecast 'time' hour ahead
        % create function that selects the right inputs among the training data
        [input, target] = HourlyInputTarget(trainingData, i+time, i);
        [ newInput, hiddenOutput, output ] = calcOutput( input, inputWeights, hiddenWeights, outputWeights ); % prediction
        %Back propagation
        [ inputWeights, hiddenWeights ] = BackP( output, target, outputWeights, inputWeights, hiddenOutput, newInput,n );
        trainCount=trainCount+1;
    end
end
% ANNinfo = sprintf('ANN created. \nNumber of input nodes:%d \nNumber of Hidden nodes:%d \nLearning rate:%.4f\n',numInput,numHidden,n); 
% disp(ANNinfo)
% message = sprintf('ANN Succesfully trained with');
% confirmationMessage = sprintf('%s %d training examples.\n',message,trainCount);
% disp(confirmationMessage)

end

