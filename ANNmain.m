close all
clear
clc
 
%%

% Scaling parameters
daysBefore = 2;
hoursbefore = 4;
numInput = 4 + (daysBefore + hoursbefore); % Number of input nodes

runHidden = 1; % How many hidden nerouns to start with
endHidden = 15; % Number of hidden nodes to end with

learningRate = 0.01; % Learning rate
NumbHiddLay=1; % Number of hidden layers


% Starting index for training and validation
start = 1;
if daysBefore ~= 0
    start = start + daysBefore*96;
else
    start = start + hoursbefore*4;
end

%%

% Load training data and concatenate
Pwind = importdata('Pwind_6month_training.mat');
Psun = importdata('Psun_6month_training.mat');
Ptemp = importdata('Ptemp_6month_training.mat');
Rtemp = importdata('Rtemp_6month_training.mat');
trainingData = [Pwind, Psun, Ptemp, Rtemp];


% Load validation data and concatenate
Pwind = importdata('Pwind_6month_validation.mat');
Psun = importdata('Psun_6month_validation.mat');
Ptemp = importdata('Ptemp_6month_validation.mat');
Rtemp = importdata('Rtemp_6month_validation.mat');
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

for runHidden=1:endHidden % Loop that iterates thorugh the layers
    
    % Training returns the weights for validation ANN

    [inputWeights, hiddenWeights, outputWeights] = TrainingANN(TrainingInput, numInput, runHidden, NumbHiddLay, learningRate);

    % Validation and classification of results

    [good, bad, RMSE, MAPE, Corr] = ValidationANN( ValidationInput, inputWeights, hiddenWeights, outputWeights );
    endReport(runHidden,:) = [numInput, runHidden, NumbHiddLay, learningRate, good, bad, RMSE, MAPE, Corr]; % Final report
end

samples = (good+bad);

EndReportAnalysis(endReport, samples, endHidden);
