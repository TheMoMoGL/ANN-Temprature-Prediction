close all
clear
clc

%%


% Scaling parameters
daysBefore = 0;
hoursbefore = 2;
numInput = 4 + (daysBefore + hoursbefore); % Number of input nodes

runHidden = 1; % How many hidden nerouns to start with
endHidden = 3; % Number of hidden nodes to end with

learningRate = 0.1; % Learning rate
NumbHiddLay=1; %Number of hidden layers


% Starting index for training and validation
start = 1;
if daysBefore ~= 0
    start = start + daysBefore*96;
else
    start = start + hoursbefore*4;
end

%%

% Load training data and concatenate
Pwind = importdata('Pwind_training.mat');
Psun = importdata('Psun_training.mat');
Ptemp = importdata('Ptem_training.mat');
Rtemp = importdata('Rtemp_training.mat');
trainingData = [Pwind, Psun, Ptemp, Rtemp];


% Load validation data and concatenate
Pwind = importdata('Pwind_validation.mat');
Psun = importdata('Psun_validation.mat');
Ptemp = importdata('Ptemp_validation.mat');
Rtemp = importdata('Rtemp_validation.mat');
validationData = [Pwind, Psun, Ptemp, Rtemp];




%%

% Outlier detection
for t = 1:3
    processedTrainingData(:,t) = Pre_process(trainingData(:,t));
end

a = 1;
for i = start:length(Rtemp)-(start-1)
    TrainingInput(a,:) = [processedTrainingData(i,1:3), InputParameters( Rtemp, daysBefore, hoursbefore, i )];
    a = a + 1;
end

for t = 1:3
    processedValidationData(:,t) = Pre_process(validationData(:,t));
end

a = 1;
for i = start:length(Rtemp)-(start-1)
    ValidationInput(a,:) = [processedValidationData(i,1:3), InputParameters( Rtemp, daysBefore, hoursbefore, i )];
    a = a + 1;
end

[TrainingInput, maxValuesTrain, minValuesTrain] = MaxAndMin(TrainingInput);
[ValidationInput, maxValuesVali, minValuesVali] = MaxAndMin(ValidationInput);

%%

for runHidden = 1:endHidden % Loop that iterates thorugh the layers
%      startline = sprintf('--------------------------Nr.input nodes:%d-----Nr.Hidden nodes:%d------------------------------',numInput,runHidden); %for clarity in the information
%      disp(startline) % Start the run
    
    
    % Training returns the weights for validation ANN

    [inputWeights, hiddenWeights] = TrainingANN(TrainingInput, numInput, runHidden, NumbHiddLay, learningRate);

    
    % Validation and classification of results
    [good, bad, RMSE, MAPE, Corr] = ValidationANN(ValidationInput, inputWeights, hiddenWeights, maxValuesTrain, minValuesTrain);
    endReport(runHidden,:) = [numInput, runHidden, NumbHiddLay, learningRate, good, bad, RMSE, MAPE, Corr]; % Final report
end

samples = (good+bad);
 EndReportAnalysis(endReport, samples, endHidden);

