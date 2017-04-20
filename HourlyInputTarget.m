function [ input, target ] = HourlyInputTarget( trainingData,index )
%HOURLYINPUTTARGET Summary of this function goes here
%   Detailed explanation goes here
     input = [trainingData(index+3, 1) trainingData(index, 2) trainingData(index+3, 3) trainingData(index+3, 4)];
     target=trainingData(index);
end

