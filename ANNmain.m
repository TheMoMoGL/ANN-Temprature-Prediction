close all
clear
clc
close all
% Scaleing parameters
daysBefore = 0;
hoursbefore = 3;
numInput = 4 + (daysBefore + hoursbefore); % number of input nodes
runHidden=1; %How many hidden nerouns to start with
endHidden = 3; % number of hidden nodes ti ebd wutg
% Starting inedx for training and validation
start = 1;
if daysBefore ~= 0
    start = start + daysBefore*96; 
else
    start = start + hoursbefore*4;
end
learningRate = 0.1; % learning rate

% Concatenate data
Pwind = importdata('Pwind_training.mat');
Psun = importdata('Psun_training.mat');
Ptemp = importdata('Ptem_training.mat');
Rtemp = importdata('Rtemp_training.mat');
trainingData = [Pwind, Psun, Ptemp, Rtemp];

processedTrainingData = zeros(size(trainingData));
for runHidden=1:endHidden %Loop that itterats thorugh the layers
 startline = sprintf('--------------------------Nr.input nodes:%d-----Nr.Hidden nodes:%d------------------------------',numInput,runHidden); %for clarity in the information
disp(startline) %start the run
% Outlier detection
for t = 1:3
    processedTrainingData(:,t) = Pre_process(trainingData(:,t));
end

a=1;
for i=start:length(Rtemp)-(start-1)
    TrainingInput(a,:) = [processedTrainingData(i,1:3), InputParameters( Rtemp, daysBefore, hoursbefore, i )];
    a = a+1;
end


% Training returns the weights for validation ANN

[ inputWeights, hiddenWeights ] = TrainingANN( TrainingInput, numInput, runHidden, learningRate );

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

a=1;
for i=start:length(Rtemp)-(start-1)
    ValidationInput(a,:) = [processedValidationData(i,1:3), InputParameters( Rtemp, daysBefore, hoursbefore, i )];
    a = a+1;
end

[good, bad, RMSE, MAPE, Corr] = ValidationANN( ValidationInput, inputWeights, hiddenWeights);
endreport(runHidden,:)=[numInput, runHidden, learningRate, good, bad, RMSE, MAPE, Corr]; %final report
end

EndReportAnalysis(endreport);


