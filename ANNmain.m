clear all
clc
% Scaleing parameters
numInput = 4; % number of input nodes
numHidden = 6; % number of hidden nodes
n = 0.1; % learning rate

% Concatenate data
Pwind = importdata('Pwind_training.mat');
Rtemp = importdata('Rtemp_training.mat');
Ptemp = importdata('Ptem_training.mat');
Psun = importdata('Psun_training.mat');
trainingData = [Pwind, Rtemp, Ptemp, Psun];

% Outlier detection

%Training return the weights for validation ANN
[ inputWeights, hiddenWeights ] = TrainingANN( trainingData, numInput, numHidden, n );

% Validation with the trained weights
Pwind = importdata('Pwind_validation.mat');
Rtemp = importdata('Rtemp_validation.mat');
Ptemp = importdata('Ptemp_validation.mat');
Psun = importdata('Psun_validation.mat');
validationData = [Pwind, Rtemp, Ptemp, Psun];

[good, bad] = ValidationANN( validationData, inputWeights, hiddenWeights )