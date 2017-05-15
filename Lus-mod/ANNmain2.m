clear
clc
%%
goodComp = 0;
% Scaling parameters

daysBefore = 1;
hoursbefore = 10;
time = 24; % How many hours to forecast between 1-24
endHidden = 10; % Number of hidden nodes to end with
numInput = 4 + (daysBefore + hoursbefore); % Number of input nodes
starthidden = 1; % How many hidden nodes in each layer to start out with
learningRate = 0.001; % Learning rate
NumbHiddLay = 2; % Number of hidden layers
K_factor = 3; % Constant used for k-fold cross validaton
start = 1; % Starting index for training and validation
counter = 0; % Counter for report matrix
period = 1; % How big period the year shall be divided into

% Starting index for training and validation
if daysBefore ~= 0
    start = start + daysBefore*96;
else
    start = start + hoursbefore*4;
end

%%
monthlyPeriod = 1;
for p = 1 :period: 12
    [Data14, Data15, Data16] = Data_deviding(p, ((p-1)+period));
    
    totalData = [Data14; Data15; Data16];
    
    partition = round(length(totalData)/K_factor); % Divides data after k-fold constant
    iterate = partition*2;
    
    for parameter = 1:4
        [training(:,parameter), validation(:,parameter)] = k_fold(totalData(:,parameter), K_factor, iterate, partition);
    end
    
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
    
    lengthTrain = length(TrainingInput);
    totalInput = [TrainingInput; ValidationInput];
    [totalNormal, Max, Min] = MaxAndMin(totalInput);
    TrainingInput = totalNormal(1:lengthTrain, :);
    goodTrained = 0;
    for runHidden = starthidden:endHidden % Loop that iterates thorugh the layers
        [inputWeights, hiddenWeights, outputWeights, layers, good] = ANNtraining(TrainingInput, numInput, runHidden, NumbHiddLay, learningRate, training(:,4), time);
        % Saves the necessary data from the best trained ANN in an struct array
        if good > goodTrained
            goodTrained = good;
            field1 = 'Input';  value1 = inputWeights;
            field2 = 'Hidden';  value2 = hiddenWeights;
            field3 = 'Output';  value3 = outputWeights;
            field4 = 'Max';  value4 = Max;
            field5 = 'Min';  value5 = Min;
            field6 = 'Layers';  value6 = layers;
            field7 = 'Data'; value7 = ValidationInput;
            A{monthlyPeriod} = struct(field1, value1, field2, value2, field3, value3,...
                field4, value4, field5, value5, field6, value6, field7, value7);
        end
    end
    monthlyPeriod = monthlyPeriod +1;
    % clears parameters that are going to change size the next iteration
    clearvars training validation processedTrainingData TrainingInput ValidationInput processedValidationData
end


% Validation
[good, bad, RMSE, MAPE, Corr, ValidationError, outputValid, targetValid] = ANNvalidation(A, time);
good / (good+bad)
RMSE
MAPE
Corr
if goodComp < good
    goodComp = good;
    bestHiddNeurons = runHidden;   % Saves the best output and target matrix
    bestOutputValid = outputValid;
    bestTargetValid = targetValid;
end
endReport(runHidden,:) = [numInput, runHidden, NumbHiddLay, learningRate, good, bad, RMSE, MAPE]; % Final report

goodSMHI = 0;
badSMHI = 0;
count = 1;
for j = 1: length(A)
    for i = 1:4:length(A{1,j}.Data)
        
        if abs(A{1,j}.Data(i,3) - A{1,j}.Data(i,4)) < 2
            goodSMHI = goodSMHI + 1;
        else
            badSMHI = badSMHI + 1;
        end
        
        progTemp(count) = A{1,j}.Data(i,3);
        count = count + 1;
    end
end
sprintf('Good SMHI: %d \nBad SMHI: %d', goodSMHI, badSMHI)

samples = (good+bad);
% bestrun = EndReportcompilation(endReport, samples, endHidden, bestOutputValid, bestTargetValid, bestHiddNeurons, progTemp); %endReport compilation in progess