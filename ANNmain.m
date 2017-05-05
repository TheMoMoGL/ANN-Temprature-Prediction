close all
clear
clc

%%
goodComp=0;
dateAndTime = loadVariable('Date_Time_validation.mat'); %Loading validations date and time
% Scaling parameters

daysBefore = 1;
hoursbefore = 5;

numInput = 4 + (daysBefore + hoursbefore); % Number of input nodes
starthidden=2;
% runHidden = 1; % How many hidden nerouns to start with

endHidden = 15; % Number of hidden nodes to end with
learningRate = 0.00001; % Learning rate
NumbHiddLay = 2; % Number of hidden layers

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



for runHidden = starthidden:endHidden % Loop that iterates thorugh the layers
    % Training returns the weights for validation ANN
    [inputWeights, hiddenWeights, outputWeights] = TrainingANN(TrainingInput, numInput, runHidden, NumbHiddLay, learningRate, training(:,4));
    

    % Validation

    [good, bad, RMSE, MAPE, Corr, outputValid, targetValid] = ValidationANN( ValidationInput, inputWeights, hiddenWeights, outputWeights, validation(:,4));
    
    if goodComp < good
        goodComp = good;
        bestHiddNeurons = runHidden;   %Saves the best output and target matrix
        bestOutputValid = outputValid;
        bestTargetValid = targetValid;
    end
    
    endReport(runHidden,:) = [numInput, runHidden, NumbHiddLay, learningRate, good, bad, RMSE, MAPE, Corr]; % Final report
    
end


samples = (good+bad);
EndReportcompilation(endReport, samples, endHidden, bestOutputValid, bestTargetValid, bestHiddNeurons, dateAndTime); %endReport compilation in progess
