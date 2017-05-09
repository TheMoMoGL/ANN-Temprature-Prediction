function [bestrun] = EndReportcompilation(endReport, samples, endHidden, outputValid, targetValid, bestHiddNeurons, progTemp)

 bestrun = EndReportAnalysis(endReport, samples, endHidden);
 graphs(outputValid(:,1), targetValid(:,1), bestHiddNeurons, progTemp);
 
end