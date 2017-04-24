close all
clear
clc

% Scaling parameters
numInput = 4; % Number of input nodes
numHidden = 6; % Number of hidden nodes
n = 0.1; % Learning rate

% Concatenate data
Pwind = importdata('Pwind_training.mat');
Psun = importdata('Psun_training.mat');
Ptemp = importdata('Ptem_training.mat');
Rtemp = importdata('Rtemp_training.mat');
trainingData = [Pwind, Psun, Ptemp, Rtemp];

processedTrainingData = zeros(size(trainingData));


% Outlier detection
for t = 1:3
    processedTrainingData(:,t) = Pre_process(trainingData(:,t));
end

processedTrainingData(:,4) = trainingData(:,4);


% Training returns the weights for validation ANN
[ inputWeights, hiddenWeights ] = TrainingANN( processedTrainingData, numInput, numHidden, n );
% Validation with the trained weights
Pwind = importdata('Pwind_validation.mat');
Psun = importdata('Psun_validation.mat');
Ptemp = importdata('Ptemp_validation.mat');
Rtemp = importdata('Rtemp_validation.mat');
validationData = [Pwind, Psun, Ptemp, Rtemp];

processedValidationData = zeros(size(validationData));

% Outlier detection
for t = 1:3
    processedValidationData(:,t) = Pre_process(validationData(:,t));
end

processedValidationData(:,4) = validationData(:,4);

[good, bad] = ValidationANN( processedValidationData, inputWeights, hiddenWeights );