function [Bestrun] = EndReportAnalysis(endreport, samples, endHidden)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: endreport -> Report containg all the information [numInput, runHidden, NumbHidLay, learningRate, good, bad, RMSE, MAPE, Corr]
%            
%
% Outputs: 
%          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1)       % add first plot in 2 x 2 grid
stem(endreport(:,2),endreport(:,5))           % stem plot
title('Good predictions')
axis([1 endHidden 0 samples])

subplot(2,2,2)       % add second plot in 2 x 2 grid
stem(endreport(:,2),endreport(:,7))       % stem plot
title('Root-mean-square deviation')

subplot(2,2,3)       % add third plot in 2 x 2 grid
stem(endreport(:,2),endreport(:,8))           % stem plot
title('Mean absolute percentage error')

subplot(2,2,4)       % add fourth plot in 2 x 2 grid
stem(endreport(:,2),endreport(:,9))           % stem plot
title('Correlation')

[~,I] = max(endreport(:,5));
Bestrun=endreport(I,:);


confirmationMessage = sprintf('Optimal ANN with highest correlation \nInput nodes:%d \nHidden nodes:%d \nHidden layers:%d \nLearning rate:%.4f \nGood predictions:%d \nBad predictions:%d \nRMSE:%.6f \nMAPE: %.6f \nCorr:%.6f' ...
,endreport(I,1),endreport(I,2),endreport(I,3),endreport(I,4),endreport(I,5),endreport(I,6),endreport(I,7),endreport(I,8),endreport(I,9));
disp(confirmationMessage)

end

