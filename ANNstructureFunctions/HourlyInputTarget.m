function [ input, target ] = HourlyInputTarget( trainingData, indexForecast, indexReal, trainingTarget )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In: trainingData -> Matrix with training data
%     indexForecast -> Index to take forecast data from in trainingData
%     indexReal -> Index to take hourly data from training data
%     trainingTarget -> Vector with all targets (the real temperature)
%     indexForecast ->  To take out target temprature from  trainingTarget.
%     trainingTarget -> Vector with target temprature for ANN training.
% Out: input -> Vector with input parameters
%      target -> The temperature the 'input' vector is suppose
%                to forecast in the function 'calcOutput'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dataSize = size(trainingData);
input = [trainingData(indexForecast, 1) trainingData(indexForecast, 2) trainingData(indexForecast, 3)...
         trainingData(indexReal, 4:dataSize(2))];
target=trainingTarget(indexForecast);
end
