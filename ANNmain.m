% close all
% clear
% clc

%%
rng('default')
global start;
global validation;

goodComp = 0;
% Scaling parameters
% daysBefore = 1;
% hoursbefore = 4;
% time = 24; % How many hours to forecast between 1-24
% endHidden = 20; % Number of hidden nodes to end with
numInput = 4 + (daysBefore + hoursbefore); % Number of input nodes
% starthidden = 1; % How many hidden nodes in each layer to start out with
% learningRate = 0.00001; % Learning rate
% NumbHiddLay = 1; % Number of hidden layers
% K_factor = 3; % Constant used for k-fold cross validaton
start = 1; % Starting index for training and validation
counter = 0; % Counter for report matrix

% Start_month = 1;
% End_month = 2;


% Starting index for training and validation
if daysBefore ~= 0
    start = start + daysBefore*96;
else
    start = start + hoursbefore*4;
end

[Data14, Data15, Data16] = Data_deviding(Start_month, End_month);

training = vertcat(Data14, Data15);
validation = Data16;

% totalData = [Data14; Data15; Data16];
% partition = round(length(totalData)/K_factor); % Divides data after k-fold constant
% iterate = 1;
% iterate = partition;
% iterate = partition*2;
% iterate = 1:partition:length(totalData);

% for parameter = 1:4
%     [training(:,parameter), validation(:,parameter)] = k_fold(totalData(:,parameter), K_factor, iterate, partition);
% end

% Outlier detection
for t = 1:2:3
    processedTrainingData(:,t) = Pre_process(training(:,t));
end
processedTrainingData(:,2) = training(:,2);

a = 1;
for i = start:length(training)-(start-1)
    TrainingInput(a,:) = [processedTrainingData(i,1:3), InputParameters( training(:,4), daysBefore, hoursbefore, i )];
    a = a + 1;
end

for t = 1:2:3
    processedValidationData(:,t) = Pre_process(validation(:,t));
end
processedValidationData(:,2) = validation(:,2);

a = 1;
for i = start:length(validation)-(start-1)
    ValidationInput(a,:) = [processedValidationData(i,1:3), InputParameters( validation(:,4), daysBefore, hoursbefore, i )];
    a = a + 1;
end

[TrainingInput, maxValuesTrain, minValuesTrain] = MaxAndMin(TrainingInput);
ValidationInput = Normalisation(ValidationInput, maxValuesTrain, minValuesTrain);
% [ValidationInput, maxValuesVali, minValuesVali] = MaxAndMin(ValidationInput);

% lengthTrain = length(TrainingInput);
% totalInput = [TrainingInput; ValidationInput];
% [totalNormal, ~, ~] = MaxAndMin(totalInput);
% TrainingInput = totalNormal(1:lengthTrain, :);
% ValidationInput = totalNormal(lengthTrain + 1:end, :);


for runHidden = starthidden:endHidden % Loop that iterates thorugh the layers
    % Training returns the weights for validation ANN
    [inputWeights, hiddenWeights, outputWeights] = TrainingANN(TrainingInput, numInput, runHidden, NumbHiddLay, learningRate, training(:,4), time);
    
    % Validation
    [good, bad, RMSE, MAPE, Corr, outputValid, targetValid] = ValidationANN(ValidationInput, inputWeights, hiddenWeights, outputWeights, validation(:,4), NumbHiddLay, time);
    
    if goodComp < good
        goodComp = good;
        bestHiddNeurons = runHidden;   % Saves the best output and target matrix
        bestOutputValid = outputValid;
        bestTargetValid = targetValid;
%         Terror = trainError;
%         Verror = ValidationError;
    end
    endReport(runHidden,:) = [numInput, runHidden, NumbHiddLay, learningRate, good, bad, RMSE, MAPE, Corr]; % Final report
end

% end
goodSMHI = 0;
badSMHI = 0;
count = 1;
for i = start:4:length(validation)
    
    if abs(validation(i,3) - validation(i,4)) < 2
        goodSMHI = goodSMHI + 1;
    else
        badSMHI = badSMHI + 1;
    end
    
    progTemp(count) = validation(i,3);
    count = count + 1;
end
SMHIPercent=(goodSMHI/(goodSMHI+badSMHI)*100);
 sprintf('Good SMHI: %d \nBad SMHI: %d', goodSMHI, badSMHI)

samples = (good+bad);
% bestrun = EndReportcompilation(endReport, samples, endHidden, bestOutputValid, bestTargetValid, bestHiddNeurons, progTemp); %endReport compilation in progess

