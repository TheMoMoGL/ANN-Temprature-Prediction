function [ ] = EndReportcompilation( endReport, samples, endHidden, outputValid, targetValid, bestHiddNeurons, dateAndTime )
%ENDREPORTCOMPILIATION Summary of this function goes here
%   Detailed explanation goes here

 EndReportAnalysis(endReport, samples, endHidden);
 graphs(outputValid(:,1), targetValid(:,1), dateAndTime, bestHiddNeurons);
 
end

