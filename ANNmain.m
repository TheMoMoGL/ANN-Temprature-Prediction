% Scaleing parameters
numInput = 4; % number of input nodes
numHidden = 6; % number of hidden nodes
n = 0.1; % learning rate

% Concatenate data
Pwind = importdata('WindProg2015.mat');
Rtemp = importdata('TempReal2015.mat');
Ptemp = importdata('TempProg2015.mat');
Psun = importdata('SunProg2015.mat');

trainingData = [Pwind, Rtemp, Ptemp, Psun];

% Outlier detection

%Training return the weights for validation ANN
[ inputWeights, hiddenWeights ] = TrainingANN( trainingData, numInput, numHidden, n );

 % Validation with the trained weights
 [ newInput, hiddenOutput, output ] = calcOutput( input, inputWeights, hiddenWeights ); % prediction