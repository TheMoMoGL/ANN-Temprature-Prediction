function [ input, target ] = HourlyInputTarget( trainingData,indexForecast, indexReal,trainingTarget )
dataSize = size(trainingData);
     input = [trainingData(indexForecast, 1) trainingData(indexForecast, 2) trainingData(indexForecast, 3)...
         trainingData(indexReal, 4:dataSize(2))];
     target=trainingTarget(indexForecast);
end
