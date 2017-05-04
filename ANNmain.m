close all
clear
clc
 
%%

% Scaling parameters
daysBefore = 1;
hoursbefore = 4;
numInput = 4 + (daysBefore + hoursbefore); % Number of input nodes

runHidden = 1; % How many hidden nerouns to start with
endHidden = 12; % Number of hidden nodes to end with

learningRate = 0.01; % Learning rate
NumbHiddLay = 1; % Number of hidden layers

K_factor = 3;


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

totalData = [trainingData; validationData];

iterate = 1;
partition = round(length(totalData)/K_factor);
%for iterate = 1:partition:length(totalData)
    
    for parameter = 1:4
        [training(:,parameter), validation(:,parameter)] = k_fold(totalData(:,parameter), K_factor, iterate, partition);
    end
    
%end


%%

% Outlier detection
 for t = 1:3
    processedTrainingData(:,t) = Pre_process(training(:,t));
 end

a = 1;

for i = start:length(training)-(start-1)
    TrainingInput(a,:) = [processedTrainingData(i,1:3), InputParameters( training(:,4), daysBefore, hoursbefore, i )];
    a = a + 1;
end

for t = 1:3
    processedValidationData(:,t) = Pre_process(validation(:,t));
end

a = 1;
for i = start:length(validation)-(start-1)
    ValidationInput(a,:) = [processedValidationData(i,1:3), InputParameters( validation(:,4), daysBefore, hoursbefore, i )];
    a = a + 1;
end

[TrainingInput, maxValuesTrain, minValuesTrain] = MaxAndMin(TrainingInput);
[ValidationInput, maxValuesVali, minValuesVali] = MaxAndMin(ValidationInput);

%%
good = 0;
bad = 0;
total = length(totalData);

for runHidden=1:endHidden % Loop that iterates thorugh the layers
    

    while(good/total) > 0.80
        % Training returns the weights for validation ANN
        [inputWeights, hiddenWeights, outputWeights, good] = TrainingANN(TrainingInput, numInput, runHidden, NumbHiddLay, learningRate);
    end

    % Validation and classification of results
    [good, bad, RMSE, MAPE, Corr] = ValidationANN( ValidationInput, inputWeights, hiddenWeights, outputWeights );
    endReport(runHidden,:) = [numInput, runHidden, NumbHiddLay, learningRate, good, bad, RMSE, MAPE, Corr]; % Final report
end

samples = (good+bad);

EndReportAnalysis(endReport, samples, endHidden);
