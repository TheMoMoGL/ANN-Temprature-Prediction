function [test, train] = k_fold(Observations, K_factor)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K-fold cross validation
%
% Inputs: 
%
% Outputs:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% indices = crossvalind('Kfold', Observations, K_factor);
C = cvpartition(Observations,'KFold',K_factor);


% for i = 1:K_factor
%     test = (indices == i); train = ~test;
% end

end