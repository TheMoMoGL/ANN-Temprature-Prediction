function [bestrun] = EndReportcompilation(endReport, samples, endHidden, outputValid, targetValid, bestHiddNeurons, progTemp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: endreport -> Report containg all the information [numInput, runHidden, NumbHidLay, learningRate, good, bad, RMSE, MAPE, Corr]
%         samples -> Number of predicionts
%         endHidden -> The number of hidden neruon which gave the best result
%         outputValid -> Set with output from the ANN, set of output from the best run. (Based on how many good predictions)  
%         targetValid -> The corresponding target temprature (real temprature)for the output from the ANN.
%         progTemp -> 
% 
% 
%
% Outputs: Bestrun the index for the run that gave the best result, index
% is for endreport.
%          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


 bestrun = EndReportAnalysis(endReport, samples, endHidden);
 graphs(outputValid, targetValid, bestHiddNeurons, progTemp);
 
end