function [ ] = EndReportcompilation(endReport, samples, endHidden, outputValid, targetValid, bestHiddNeurons, dateAndTime, progTemp)

 EndReportAnalysis(endReport, samples, endHidden);
 graphs(outputValid(:,1), targetValid(:,1), dateAndTime, bestHiddNeurons, progTemp);
 
end