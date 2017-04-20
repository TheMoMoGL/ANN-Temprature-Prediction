function [ input, target ] = HourlyInputTarget( trainingData,indexForecast, indexReal )
%HOURLYINPUTTARGET Summary of this function goes here
%   Detailed explanation goes here
     input = [trainingData(indexForecast, 1) trainingData(indexReal, 2) trainingData(indexForecast, 3) trainingData(indexForecast, 4)];
     target=trainingData(indexReal,2);
end
