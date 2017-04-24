function [ input, target ] = HourlyInputTarget( trainingData,indexForecast, indexReal )

     input = [trainingData(indexForecast, 1) trainingData(indexForecast, 2) trainingData(indexForecast, 3)...
         trainingData(indexReal, 4)];
     target=trainingData(indexForecast, 4);
end
