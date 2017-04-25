function [] = EndReportAnalysis(endreport, samples, endHidden)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inputs: endreport -> Report containg all the information [numInput, runHidden, learningRate, good, bad, RMSE, MAPE, Corr]
%            
%
% Outputs: 
%          
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure
subplot(2,2,1)       % add first plot in 2 x 2 grid
stem(endreport(:,2),endreport(:,4))           % stem plot
title('Good predictions')
axis([0 endHidden 0 samples])

subplot(2,2,2)       % add second plot in 2 x 2 grid
stem(endreport(:,2),endreport(:,6))       % stem plot
title('Root-mean-square deviation')

subplot(2,2,3)       % add third plot in 2 x 2 grid
stem(endreport(:,2),endreport(:,7))           % stem plot
title('Mean absolute percentage error')

subplot(2,2,4)       % add fourth plot in 2 x 2 grid
stem(endreport(:,2),endreport(:,8))           % stem plot
title('Correlation')

end

