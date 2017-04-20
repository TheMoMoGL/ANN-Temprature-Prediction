% Scaleing parameters
numInput = 4; % number of input nodes
numHidden = 3; % number of hidden nodes
n = 0.1; % learning rate

% Concatenate data
Pwind = importdata('WindProg2015.mat');
Rtemp = importdata('TempReal2015.mat');
Ptemp = importdata('TempProg2015.mat');
Psun = importdata('SunProg2015.mat');

trainingData = [Pwind, Rtemp, Ptemp, Psun];

% Normilise
trainingData = Normalisation(trainingData);

% Outlier detection

% Generate weights
[inputWeights, hiddenWeights] = WeightsGenerator(numInput, numHidden);

% Training
for i=1:length(trainingData)-3
    % create function that selects the right inputs among the training data
    input = [trainingData(i+3, 1) trainingData(i, 2) trainingData(i+3, 3) trainingData(i+3, 4)];
    [ newInput, hiddenInput, hiddenOutput, output ] = calcOutput( input, inputWeights, hiddenWeights ); % prediction
    %Back propagation
    [ inputWeights, hiddenWeights ] = BackP( output, target, hiddenWeights, inputWeights, hiddenOutput, newInput );
end
 % Validation