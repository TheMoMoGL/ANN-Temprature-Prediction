function [ ] = EndReportcompilation( endReport, samples, endHidden, outputValid, targetValid, bestHiddNeurons, dateAndTime )

 EndReportAnalysis(endReport, samples, endHidden);
 graphs(outputValid(:,1), targetValid(:,1), dateAndTime, bestHiddNeurons);
 
end