close all
clear
clc

%%
goodComp = 0;
dateAndTime = loadVariable('Date_Time_validation.mat'); % Loading validations date and time
% Scaling parameters

daysBefore = 2;
hoursbefore = 4;
time = 24; % how many hours to forecast between 1-24.
numInput = 4 + (daysBefore + hoursbefore); % Number of input nodes
starthidden = 2;
endHidden = 20; % Number of hidden nodes to end with
learningRate = 0.0000001; % Learning rate
NumbHiddLay = 2; % Number of hidden layers
K_factor = 3; % Constant used for k-fold cross validaton
start = 1; % Starting index for training and validation
counter = 0;


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

partition = round(length(totalData)/K_factor); % Divides data after k-fold constant
%iterate = partition*2;


for iterate = 1:partition:length(totalData)
    
    counter = counter + 1;
    
    for parameter = 1:4
        [training(:,parameter), validation(:,parameter)] = k_fold(totalData(:,parameter), K_factor, iterate, partition);
    end
    
    
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
    
    % Outlier detection
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
        [inputWeights, hiddenWeights, outputWeights] = TrainingANN(TrainingInput, numInput, runHidden, NumbHiddLay, learningRate, training(:,4), time);
        
        % Validation
        [good, bad, RMSE, MAPE, Corr, outputValid, targetValid] = ValidationANN(ValidationInput, inputWeights, hiddenWeights, outputWeights, validation(:,4), time);
        
        if goodComp < good
            goodComp = good;
            bestHiddNeurons = runHidden;   %Saves the best output and target matrix
            bestOutputValid = outputValid;
            bestTargetValid = targetValid;
        end
        
        endReport(runHidden,:) = [numInput, runHidden, NumbHiddLay, learningRate, good, bad, RMSE, MAPE, Corr]; % Final report
        
    end
    
    % end
    good2 = 0;
    bad2 = 0;
    for i = 1:4:length(validation)
        
        if abs(validation(i,3) - validation(i,4)) < 2
            good2 = good2 + 1;
        else
            bad2 = bad2 + 1;
            
        end
    end
    
    sprintf('Good SMHI: %d \nBad SMHI: %d', good2, bad2)
    
    progTemp = validation(:,3);
    samples = (good+bad);
    bestrun = EndReportcompilation(endReport, samples, endHidden, bestOutputValid, bestTargetValid, bestHiddNeurons, dateAndTime, progTemp); %endReport compilation in progess
    
    reports(counter,:) = bestrun;
end % Ends k-fold for loop